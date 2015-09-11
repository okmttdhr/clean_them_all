# == Schema Information
#
# Table name: clean_them_all_job_progressions
#
#  id            :integer          default(0), not null, primary key
#  aasm_state    :string(30)       not null
#  collect_count :integer          default(0)
#  filter_count  :integer          default(0)
#  destroy_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_clean_them_all_job_progressions_on_aasm_state  (aasm_state)
#

require 'rails_helper'

RSpec.describe JobProgression, type: :model do
end
