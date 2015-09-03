# == Schema Information
#
# Table name: clean_them_all_jobs
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  aasm_state :string(30)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_clean_them_all_jobs_on_aasm_state  (aasm_state)
#  index_clean_them_all_jobs_on_user_id     (user_id)
#

class Job < ActiveRecord::Base
  include Publishable

  belongs_to :user
  has_one :parameter, class_name: 'JobParameter', foreign_key: :id
  has_one :progression, class_name: 'JobProgression', foreign_key: :id

  ##############################################################################
  scope :active, -> { where(aasm_state: %i(processing confirming closing)) }

  ##############################################################################
  include AASM

  aasm column: :aasm_state do
    state :processing, initial: true
    state :confirming
    state :closing
    state :closed

    event :finish do
      transitions to: :confirming, from: [:processing]
    end

    event :abort do
      transitions to: :confirming, from: [:processing]
    end

    event :confirm do
      transitions to: :closing, from: [:confirming]
    end

    event :close do
      transitions to: :closed, from: [:closing]
    end
  end

  def inprogress?
    processing? || confirming?
  end
end
