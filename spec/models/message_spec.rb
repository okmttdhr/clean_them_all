require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '.count' do
    subject { Message.count }
    it { is_expected.to be_kind_of Integer }
  end
end
