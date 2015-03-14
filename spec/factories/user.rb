FactoryGirl.define do
  factory :user do
    id                 { Faker::Number.number(18) }
    token              { "#{id}-#{Faker::Internet.password(32)}" }
    secret             { Faker::Internet.password(32) }
    name               { Faker::Internet.user_name }
  end
end
