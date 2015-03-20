module ApplicationHelper
  def barwidth(status)
    Rational(status[:destroyed_count], status[:statuses_count]) * 100
  end

  def busyness_symbols
    ServerStatus.busyness_status.each_with_object({}) do |state, hash|
      hash[state] = t("default.server_status.#{state}")
    end
  end

  def notice_messages
    index = Time.now.to_i % Message.count
    [Message.start_message[index], Message.finish_message[index]]
  end
end
