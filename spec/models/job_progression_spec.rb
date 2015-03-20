# == Schema Information
#
# Table name: job_progressions
#
#  id            :integer          not null, primary key
#  aasm_state    :string(255)
#  handle        :integer
#  collect_count :integer          default(0)
#  filter_count  :integer          default(0)
#  destroy_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe JobProgression, type: :model do
  describe '#expire?' do
    subject { job_progression.expire? }
    let(:job_progression) { build :job_progression }
    it { is_expected.to be_falsey }
  end
end
