import React from 'react'
import ReactDOM from 'react-dom'
import WebpackerReact from 'webpacker-react'

import injectTapEventPlugin from 'react-tap-event-plugin';
injectTapEventPlugin();

import Uploader from './Uploader';
import StatusPage from './StatusPage';

WebpackerReact.setup({
  StatusPage,
  Uploader
})



