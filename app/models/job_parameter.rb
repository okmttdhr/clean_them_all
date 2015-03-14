# == Schema Information
#
# Table name: job_parameters
#
#  id               :integer          not null, primary key
#  job_id           :integer          not null
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
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_job_parameters_on_job_id  (job_id) UNIQUE
#

class JobParameter < ActiveRecord::Base
  belongs_to :job

  enum collect_method: %i(timeline archive)

  def extras=(extras)
    extras.symbolize_keys!
    self.signedin_at    = extras[:signedin_at]
    self.statuses_count = extras[:statuses_count]
    self.registered_at  = extras[:registered_at]
  end

  def options=(options)
    self.collect_method   = options[:collect_method]
    self.archive_url      = options[:archive_url].presence
    self.protect_reply    = options[:protect_reply]
    self.protect_favorite = options[:protect_favorite]
    self.collect_from     = options[:collect_from].presence
    self.collect_to       = options[:collect_to].presence
    self.start_message    = options[:start_message].presence
    self.finish_message   = options[:finish_message].presence
  end
end
