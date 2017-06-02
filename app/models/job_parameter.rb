# == Schema Information
#
# Table name: job_parameters
#
#  id               :integer          not null, primary key
#  signedin_at      :datetime         not null
#  statuses_count   :integer          not null
#  registered_at    :datetime         not null
#  collect_method   :string(255)      not null
#  archive_url      :text(65535)
#  protect_reply    :boolean          default(FALSE)
#  protect_favorite :boolean          default(FALSE)
#  collect_from     :date
#  collect_to       :date
#  start_message    :text(65535)
#  finish_message   :text(65535)
#

class JobParameter < ApplicationRecord
  belongs_to :job, foreign_key: :id

  validates :archive_url, presence: true, if: -> { collect_method == 'archive' }
end
