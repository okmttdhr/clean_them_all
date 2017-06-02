import React from 'react'
import ReactDOM from 'react-dom'

import ProgressBarBox from '../components/ProgressBarBox.jsx'
import OperationBox from '../components/OperationBox.jsx'
import StatusModalBox from '../components/StatusModalBox.jsx'

class StatusPageContainer extends React.Component {
  constructor(props) {
    super(props)
  }
  requestUpdateCleanerStatus() {
    $.ajax({
      url: Routes.api_cleaner_path(),
      type: 'GET',
      dataType: 'json',
      success: (json) => {
        this.props.updateCleanerStatus(json)
      }
    })
  }
  renderComponents() {
    ReactDOM.render(
      <ProgressBarBox {...this.props.progress_bar} />,
      document.getElementById('progressbar')
    )
    ReactDOM.render(
      <OperationBox {...this.props.operation} />,
      document.getElementById('operation')
    )
  }
  unmountComponents() {
    ReactDOM.unmountComponentAtNode(document.getElementById('progressbar'));
    ReactDOM.unmountComponentAtNode(document.getElementById('operation'))
  }
  componentDidMount() {
    this.requestUpdateCleanerStatus()
    this.renderComponents()
    this.interval = setInterval( () => {
      this.requestUpdateCleanerStatus()
    }, 5000);
  }
  componentDidUpdate() {
    this.renderComponents()
  }
  componentWillUnmount() {
    this.unmountComponents()
    clearInterval(this.interval)
  }
  render() {
    return(
      <StatusModalBox {...this.props.modal} />
    )
  }
}

// export default StatusPageContainer

////////////////////////////////////////////////////////////////////////////////
import { connect } from 'react-redux'
import { updateCleanerStatus } from '../actions/rootAction'

function mapStateToProps(state) {
  return {
    progress_bar: state.progress_bar,
    operation:    state.operation,
    modal:        state.modal,
  }
}

function mapDispatchToProps(dispatch) {
  return {
    updateCleanerStatus: (cleanerStatus) => dispatch(updateCleanerStatus(cleanerStatus))
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(StatusPageContainer)
