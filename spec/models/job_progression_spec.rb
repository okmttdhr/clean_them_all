require 'rails_helper'

RSpec.describe JobProgression, type: :model do
  it_behaves_like 'progressable'

  describe 'properties' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:current_state) }
    it { is_expected.to respond_to(:collect_count) }
    it { is_expected.to respond_to(:filter_count) }
    it { is_expected.to respond_to(:destroy_count) }
    it { is_expected.to respond_to(:created_at) }
    it { is_expected.to respond_to(:updated_at) }
  end
end
