class CleanStatusDecorator < Draper::Decorator
  include ActionView::Helpers::DateHelper
  delegate_all

  def busyness
    ServerStatus.busyness_status.each_with_object({}) do |state, hash|
      hash[state] = I18n.t("default.server_status.#{state}")
    end
  end

  # FIXME: 状態別メッセージの表示ロジックを改善する
  def state_message
    if object.job.current_state == :processing
      if object.progression.current_state == :created
        '処理が開始されるのを待っています...'
      elsif [:collecting, :collected, :filtering, :filtered].include? object.progression.current_state
        'ツイート取得中...'
      elsif [:destroying, :destroyed].include? object.progression.current_state
        "#{object.progression.destroyed_count} / #{object.progression.statuses_count}"
      end
    elsif object.job.current_state == :confirming
      '完了!'
    end
  end

  # FIXME: 状態別メッセージの表示ロジックを改善する
  def state_completion_message
    case object.progression.current_state
    when :completed
      '正常に完了しました'
    when :failed
      'エラーが発生し強制終了されました'
    when :expired
      '期間内に完了しなかったため、強制終了されました'
    else
      'ユーザによりキャンセルされました'
    end
  end

  def processing_time
    from = progression.created_at
    to   = progression.updated_at
    distance_of_time_in_words(from, to)
  end
end
