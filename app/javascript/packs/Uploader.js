import React from 'react'
import ReactDOM from 'react-dom'

import FileInput from 'react-fine-uploader/file-input'
import Filename from 'react-fine-uploader/filename'
import Filesize from 'react-fine-uploader/filesize'
import Status from 'react-fine-uploader/status'
import FineUploaderTraditional from 'fine-uploader-wrappers'

const uploader = new FineUploaderTraditional({
  options: {
    request: {
      endpoint: Routes.upload_cleaner_path(),
      params: { authenticity_token: $("meta[name='csrf-token']").attr("content") }
    }
  }
})

class Uploader extends React.Component {
  constructor(props) {
    super(props)
    this.state = { submittedFiles: [], highlight: 'success' }
  }
  componentDidMount() {
    uploader.on('submitted', id => {
      var state = { submittedFiles: [id], highlight: 'success' }
      this.setState(Object.assign({}, this.state, state))
    })
    uploader.on('complete', (id, name, response) => {
      var state = { submittedFiles: [id], highlight: 'success' }
      this.setState(Object.assign({}, this.state, state))
      $('#job_parameter_archive_url').val(response.presigned_url)
    })
    uploader.on('error', (id, name, errorReason, xhr) => {
      var state = { submittedFiles: [id], highlight: 'lightpurple' }
      this.setState(Object.assign({}, this.state, state))
    })
  }
  render() {
    return (
      <div>
        <div>
          <FileInput multiple accept='application/zip' uploader={ uploader }>
            <a className='button radius tiny'>Upload</a>
          </FileInput>
        </div>
        <div>
          {
            this.state.submittedFiles.map(id => (
              <div key={id} className={`panel radius ${this.state.highlight}`}>
                <Filename id={ id } uploader={ uploader } /> <Filesize id={ id } uploader={ uploader } /> <Status id={ id } uploader={ uploader } />
              </div>
            ))
          }
        </div>
      </div>
    )
  }
}

export default Uploader
