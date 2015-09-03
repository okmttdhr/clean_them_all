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
