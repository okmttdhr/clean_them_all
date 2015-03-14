module ApplicationHelper
  def barwidth(status)
    Rational(status[:destroyed_count], status[:statuses_count]) * 100
  end

  def busyness_symbols
    ServerStatus.busyness_status.each_with_object({}) do |state, hash|
      hash[state] = t("default.server_status.#{state}")
    end
  end

  def start_message_for(seed)
    Message.start_message[seed % Message.start_message.count]
  rescue => ex
    Airbrake.notify(ex)
    nil
  end

  def finish_message_for(seed)
    Message.finish_message[seed % Message.finish_message.count]
  rescue => ex
    Airbrake.notify(ex)
    nil
  end
end
