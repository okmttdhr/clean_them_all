require 'rails_helper'

describe ApplicationHelper, type: :helper do
  describe '#barwidth' do
    subject { helper.barwidth(status) }
    let(:status) { { destroyed_count: 30, statuses_count: 60 } }
    it { is_expected.to eq 50 }
  end

  describe '#busyness_symbols' do
    subject { helper.busyness_symbols }
    let(:symbols) { {
      empty:  t('default.server_status.empty'),
      normal: t('default.server_status.normal'),
      jam:    t('default.server_status.jam'),
      halt:   t('default.server_status.halt'),
    } }
    it { is_expected.to eq symbols }
  end

  describe '#notice_messages' do
    let(:messages) { helper.notice_messages }
    it '' do
      expect(Message.start_message).to include messages[0]
      expect(Message.finish_message).to include messages[1]
    end
  end
end
