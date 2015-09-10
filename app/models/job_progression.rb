# == Schema Information
#
# Table name: clean_them_all_job_progressions
#
#  id            :integer          not null, primary key
#  aasm_state    :string(255)
#  collect_count :integer          default(0)
#  filter_count  :integer          default(0)
#  destroy_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class JobProgression < ActiveRecord::Base
  belongs_to :job

  PROCESSING_STATES = %i(created collecting collected filtering filtered destroying destroyed)
  FINISH_STATES     = %i(completed aborted failed expired)

  include AASM
  aasm do
    state :created, initial: true
    state :collecting
    state :collected
    state :filtering
    state :filtered
    state :destroying
    state :destroyed
    state :completed
    state :aborted
    state :failed
    state :expired
  end
end
