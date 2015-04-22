FactoryGirl.define do
  factory :job_progression do
    id            { Faker::Number.number(1) }
    current_state { 'created' }
    collect_count { Faker::Number.number(1) }
    filter_count  { Faker::Number.number(1) }
    destroy_count { Faker::Number.number(1) }
    created_at    { "2015-04-26 02:21:45 +0900" }
    updated_at    { "2015-04-26 02:21:45 +0900" }

    trait :with_state_completed do
      current_state { 'completed' }
    end
  end
end
