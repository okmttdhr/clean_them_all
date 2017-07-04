FactoryGirl.define do
  factory :timeline_fragment do
    id { Forgery(:basic).number(at_most: 10000000) }
  end
end
