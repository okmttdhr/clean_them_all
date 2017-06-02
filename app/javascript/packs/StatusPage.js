import React from 'react'
import { Provider } from 'react-redux'

import store from '../store/rootStore'
import StatusPageContainer from '../containers/StatusPageContainer.jsx'

const StatusPage = (props) => (
  <Provider store={store}>
    <StatusPageContainer progress_bar={props.progress_bar} operation={props.operation} modal={props.modal} />
  </Provider>
)

export default StatusPage
