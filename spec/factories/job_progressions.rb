FactoryGirl.define do
  factory :job_progression do
    id            { Forgery(:basic).number(at_most: 10000000) }
    current_state { 'created' }
    collect_count { Forgery(:basic).number }
    filter_count  { Forgery(:basic).number }
    destroy_count { Forgery(:basic).number }
    created_at    { '2015-04-26 02:21:45 +0900' }
    updated_at    { '2015-04-26 02:21:45 +0900' }

    trait :with_state_completed do
      current_state { 'completed' }
    end
  end
end
