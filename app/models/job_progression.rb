class JobProgression < ActiveRecord::Base
  include AASM

  enum handle: %i(abort)

  aasm do
    state :created, initial: true
    state :collected
    state :filtered
    state :completed
    state :aborted
    state :failed
  end

  def expire?
    # FIXME: not implemented
    false
  end
end
