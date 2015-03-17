# == Schema Information
#
# Table name: jobs
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  aasm_state :string(30)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_jobs_on_aasm_state  (aasm_state)
#  index_jobs_on_user_id     (user_id)
#

FactoryGirl.define do
  factory :job do
    aasm_state   { :processing }
    user_id      { Faker::Number.number(18) }

    trait :with_user do
      user_id    { FactoryGirl.create :user }
    end

    trait :processing do
      aasm_state { :processing }
    end
    trait :confirming do
      aasm_state { :confirming }
    end
    trait :closing do
      aasm_state { :closing }
    end
    trait :closed do
      aasm_state { :closed }
    end

    after(:create) do |job|
      FactoryGirl.create(:job_parameter, id: job.id)
      FactoryGirl.create(:job_progression, id: job.id)
    end
  end
end
