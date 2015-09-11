FactoryGirl.define do
  factory :job_progression do
    id            { Forgery(:basic).number(at_most: 10000000) }
    aasm_state    { :created }
    collect_count { Forgery(:basic).number }
    filter_count  { Forgery(:basic).number }
    destroy_count { Forgery(:basic).number }

    trait :collecting do
      aasm_state { :collecting }
    end

    trait :destroying do
      aasm_state { :destroying }
    end
  end
end
