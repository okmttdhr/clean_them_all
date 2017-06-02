import React from 'react'

const ProgressBarBox = (props) => (
  <div>
    <div className='progress bluegreen radius'>
      <div className='meter' id='bar' style={{ width: `${props.value}%` }}></div>
    </div>
    <div className='indicator text-center' id='indicator'>
      { props.state_message }
    </div>
  </div>
)

export default ProgressBarBox
