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
    id         { Forgery(:basic).number(at_most: 10000000) }
    token      { "#{id}-#{Forgery(:basic).password}" }
    secret     { Forgery(:basic).password }
    name       { Forgery(:basic).text }
  end
end
