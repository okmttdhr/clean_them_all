class Message < Settingslogic
  source "#{Rails.root}/config/messages.yml"

  def count
    raise 'message count mismatched' unless start_message.count == finish_message.count
    start_message.count
  end
end
