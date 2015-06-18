require 'rails_helper'

describe ApplicationHelper, type: :helper do
  describe '#notice_messages' do
    let(:messages) { helper.notice_messages }
    it '' do
      expect(Message.start_message).to include messages[0]
      expect(Message.finish_message).to include messages[1]
    end
  end
end
