module ApplicationHelper
  def notice_messages
    index = Time.now.to_i % Message.count
    [Message.start_message[index], Message.finish_message[index]]
  end
end
