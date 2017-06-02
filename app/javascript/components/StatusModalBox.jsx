import React from 'react'

class StatusModalBox extends React.Component {
  constructor(props) {
    super(props)
  }
  componentDidMount() {
    $('.modal-open').on('click', function() {
      $('#status-modal').remodal().open()
    })
  }
  render() {
    return(
      <div className='remodal-overlay' style={{ display: 'none' }}>
        <div className='remodal' data-remodal-id='modal' id='status-modal'>
          <table>
            <thead><tr><th className='caption' colSpan='2'>Server</th></tr></thead>
            <tbody>
              <tr><th>混雑度</th><td>{this.props.server.busyness_message}</td></tr>
              <tr><th>処理中</th><td>{this.props.server.processing_job_count} users</td></tr>
            </tbody>
          </table>
          <table>
            <thead><tr><th className='caption' colSpan='2'>Job</th></tr></thead>
            <tbody>
              <tr><th>処理対象</th><td>{this.props.job.collect_count} 件</td></tr>
              <tr><th>削除済</th><td>{this.props.job.destroy_count} 件</td></tr>
            </tbody>
          </table>
          <table>
            <thead><tr><th className='caption' colSpan='2'>Parameters</th></tr></thead>
            <tbody>
              <tr><th>Name</th><td>{this.props.job_params.user_name}</td></tr>
              <tr><th>From</th><td>{this.props.job_params.from}</td></tr>
              <tr><th>To</th><td>{this.props.job_params.to}</td></tr>
              <tr><th>Protect<br />Reply</th><td>{String(this.props.job_params.protect_reply)}</td></tr>
              <tr><th>Protect<br />Favorite</th><td>{String(this.props.job_params.protect_favorite)}</td></tr>
              <tr><th>Created At</th><td>{this.props.job_params.created_at}</td></tr>
            </tbody>
          </table>
          <a className='remodal-confirm' data-remodal-action='confirm'>OK</a>
        </div>
      </div>
    )
  }
}

export default StatusModalBox
