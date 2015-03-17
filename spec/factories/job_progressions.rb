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

FactoryGirl.define do
  factory :job_progression do
  end
end
