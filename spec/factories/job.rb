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
      create(:job_parameter, job: job)
    end
  end
end
