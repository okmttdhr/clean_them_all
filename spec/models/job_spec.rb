# == Schema Information
#
# Table name: jobs
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  aasm_state :string(30)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_jobs_on_aasm_state  (aasm_state)
#  index_jobs_on_user_id     (user_id)
#

require 'rails_helper'

describe Job, type: :model do
end
