import React from 'react'

class OperationBox extends React.Component {
  constructor(props) {
    super(props)
  }
  handleAbortButtonClick = (e) => {
    if (!this.props.abortable) {
      alert('処理は完了済みです！')
    }
  }
  handleConfirmButtonClick = (e) => {
    if (!this.props.confirmable) {
      alert('処理が完了するまでお待ちください')
    }
  }
  render() {
    return(
      <div>
        <a href={this.props.abortable ? Routes.abort_cleaner_path() : 'javascript:void(0);'} data-method='post' onClick={this.handleAbortButtonClick} className='button radius alert'>キャンセル</a>
        <a href={this.props.confirmable ? Routes.confirm_cleaner_path() : 'javascript:void(0);'} data-method='post' onClick={this.handleConfirmButtonClick} className='button radius'>結果を見る</a>
      </div>
    )
  }
}

export default OperationBox
