class JobDecorator < Draper::Decorator
  include ActionView::Helpers::DateHelper
  delegate_all

  def state_message
    if confirming?
      '完了!'
    elsif progression.collecting?
      'ツイート取得中...'
    elsif progression.destroying?
      "#{progression.destroy_count} / #{progression.filter_count}"
    end
  end

  def state_of_completion
    progression.failed? ? 'エラー中断' : '正常に完了'
  end

  def processing_time
    from = progression.created_at
    to   = progression.updated_at
    distance_of_time_in_words(from, to)
  end
end
