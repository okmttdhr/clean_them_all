# == Schema Information
#
# Table name: jobs
#
#  id                      :integer          not null, primary key
#  user_id                 :integer          not null
#  transition_state        :string(255)      not null
#  progression_state       :string(255)      not null
#  collect_count           :integer          default(0)
#  destroy_count           :integer          default(0)
#  notified_start_message  :boolean          default(FALSE)
#  notified_finish_message :boolean          default(FALSE)
#  finished_at             :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_jobs_on_progression_state             (progression_state)
#  index_jobs_on_user_id                       (user_id)
#  index_jobs_on_user_id_and_transition_state  (user_id,transition_state)
#

class Job < ApplicationRecord
  has_one    :parameter, foreign_key: :id, class_name: 'JobParameter'
  belongs_to :user

  scope :active, -> { where(transition_state: %i(processing confirming closing)) }

  validates :user_id, uniqueness: { scope: :transition_state }, on: :create

  include AASM
  aasm :transition, column: 'transition_state' do
    state :processing, initial: true
    state :confirming
    state :closing
    state :closed

    event :process do
      after do
        TimelineFragment.where(job_id: id).delete_all
        update! finished_at: DateTime.current
      end
      transitions from: :processing, to: :confirming
    end

    event :confirm do
      transitions from: :confirming, to: :closing
    end

    event :close do
      transitions from: :closing, to: :closed
    end
  end

  aasm :progression, column: 'progression_state' do
    state :collecting, initial: true
    state :cleaning
    state :completed
    state :aborted
    state :failed
    state :expired

    event :collect do
      transitions from: :collecting, to: :cleaning
    end

    event :clean, binding_event: :process do
      transitions from: :cleaning, to: :completed
    end

    event :abort, binding_event: :process do
      transitions from: %i(collecting cleaning), to: :aborted
    end

    event :fail, binding_event: :process do
      transitions from: %i(collecting cleaning), to: :failed
    end

    event :expire, binding_event: :process do
      transitions from: %i(collecting cleaning), to: :expired
    end
  end
end
