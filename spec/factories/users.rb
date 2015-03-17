# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  token      :string(255)      not null
#  secret     :string(255)      not null
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :user do
    id                 { Faker::Number.number(18) }
    token              { "#{id}-#{Faker::Internet.password(32)}" }
    secret             { Faker::Internet.password(32) }
    name               { Faker::Internet.user_name }
  end
end
