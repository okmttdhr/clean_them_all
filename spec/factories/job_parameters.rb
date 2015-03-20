# == Schema Information
#
# Table name: job_parameters
#
#  id               :integer          not null, primary key
#  signedin_at      :datetime         not null
#  statuses_count   :integer          not null
#  registered_at    :datetime         not null
#  collect_method   :integer          not null
#  archive_url      :text(65535)
#  protect_reply    :boolean          default(FALSE)
#  protect_favorite :boolean          default(FALSE)
#  collect_from     :date
#  collect_to       :date
#  start_message    :string(255)
#  finish_message   :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :job_parameter do
    # extras
    signedin_at      { DateTime.now }
    statuses_count   { Faker::Number.number(8) }
    registered_at    { 3.months.ago }

    # options
    collect_method   { JobParameter.collect_methods[:timeline]  }
    archive_url      { Faker::Internet.url }
    protect_reply    { [true, false].sample }
    protect_favorite { [true, false].sample }
    collect_from     { Faker::Time.between(2.months.ago, 1.months.ago) }
    collect_to       { Faker::Time.between(1.months.ago, 1.days.ago) }
    start_message    { Faker::Lorem.sentence }
    finish_message   { Faker::Lorem.sentence }
  end
end
