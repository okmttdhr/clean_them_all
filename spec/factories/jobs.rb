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
    id           { Forgery(:basic).number(at_most: 10000000) }
    aasm_state   { :processing }

    association :user
    association :parameter, factory: :job_parameter

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
  end
end
