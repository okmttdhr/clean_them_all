module Backend::Concerns::Services::Notifyable
  extend ActiveSupport::Concern
  include Backend::Concerns::Services::Requestable

  def notify(context)
    message_for(context).presence.try do |message|
      twitter_client.update message
    end
  rescue => ex
    # do nothing
  end

  private

  def message_for(context)
    case context
    when :start;  destroy_parameter.start_message
    when :finish; destroy_parameter.finish_message
    end
  end
end
