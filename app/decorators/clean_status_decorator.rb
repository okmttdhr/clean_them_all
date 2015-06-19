class CleanStatusDecorator < Draper::Decorator
  include ActionView::Helpers::DateHelper
  delegate_all

  def busyness
    ServerStatus.busyness_status.each_with_object({}) do |state, hash|
      hash[state] = I18n.t("default.server_status.#{state}")
    end
  end

  def state_message
    if object.job.current_state == :processing
      if object.progression.current_state == :collecting
        'ツイート取得中...'
      elsif object.progression.current_state == :destroying
        "#{object.progression.destroyed_count} / #{object.progression.statuses_count}"
      end
    elsif object.job.current_state == :confirming
      '完了!'
    end
  end

  def state_completion_message
    case object.progression.current_state
    when :completed
      '正常に完了しました'
    when :failed
      'エラーが発生し強制終了されました'
    when :collecting, :destroying, :aborted
      'ユーザによりキャンセルされました'
    end
  end

  def processing_time
    from = progression.created_at
    to   = progression.updated_at
    distance_of_time_in_words(from, to)
  end
end
