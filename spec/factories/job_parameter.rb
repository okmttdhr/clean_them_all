FactoryGirl.define do
  factory :job_parameter do
    job_id           { Faker::Number.number(8) }

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
