import { UPDATE_CLEANER_STATUS } from '../actions/rootAction'

const initialState = {
  progress_bar: {
    state_message: '処理状態を取得しています...',
    value:         0,
  },
  operation: {
    abortable:   true,
    confirmable: false,
  },
  modal: {
    server: {
      busyness:             '取得中',
      busyness_message:     '取得中',
      processing_job_count: 0,
    },
    job: {
      collect_count: 0,
      destroy_count: 0,
    },
    job_params: {
      user_name:        '取得中',
      from:             '取得中',
      to:               '取得中',
      protect_reply:    '取得中',
      protect_favorite: '取得中',
      created_at:       '取得中',
    },
  },
}

export default function rootReducer(state = initialState, action) {
  switch (action.type) {
    case UPDATE_CLEANER_STATUS:
      return Object.assign({}, state, action.cleanerStatus)
    default:
      return state
  }
}
