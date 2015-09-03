# == Schema Information
#
# Table name: clean_them_all_jobs
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  aasm_state :string(30)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_clean_them_all_jobs_on_aasm_state  (aasm_state)
#  index_clean_them_all_jobs_on_user_id     (user_id)
#

require 'rails_helper'

describe Job, type: :model do
  it_behaves_like 'publishable'

  describe 'scopes' do
    describe '.active' do
      subject { described_class.active }

      let!(:active_jobs) {
        %i(processing confirming closing).map do |state|
          create :job, state
        end
      }
      let!(:inactive_job) { create_list :job, 5, :closed }

      it 'returns only active_jobs' do
        is_expected.to match_array active_jobs
      end
    end
  end

  describe '#inprogress?' do
    context 'when job is inprogress' do
      it 'returns truthy' do
        %i(processing confirming).each do |state|
          job = build :job, state
          expect(job.inprogress?).to be_truthy
        end
      end
    end

    context 'when job is not inprogress' do
      it 'returns falsey' do
        %i(closing closed).each do |state|
          job = build :job, state
          expect(job.inprogress?).to be_falsey
        end
      end
    end
  end
end
