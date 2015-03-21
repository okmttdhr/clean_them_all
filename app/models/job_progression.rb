# == Schema Information
#
# Table name: job_progressions
#
#  id            :integer          not null, primary key
#  aasm_state    :string(255)
#  handle        :integer
#  collect_count :integer          default(0)
#  filter_count  :integer          default(0)
#  destroy_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

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

  def collecting?
    created? || collected?
  end

  def destroying?
    filtered?
  end

  def finished?
    completed? || aborted? || failed?
  end
end
