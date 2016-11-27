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
    id               { Forgery(:basic).number(at_most: 10000000) }

    # extras
    signedin_at      { DateTime.current }
    statuses_count   { Forgery('basic').number }
    registered_at    { 3.months.ago }

    # options
    collect_method   { 'timeline' }
    archive_url      { Forgery(:basic).text }
    protect_reply    { Forgery(:basic).boolean }
    protect_favorite { Forgery(:basic).boolean }
    collect_from     { Forgery(:date).date(past: true)  }
    collect_to       { Forgery(:date).date(past: false)  }
    start_message    { Forgery(:basic).text }
    finish_message   { Forgery(:basic).text }
  end
end
