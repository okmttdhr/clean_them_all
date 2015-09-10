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

require 'rails_helper'

RSpec.describe JobProgression, type: :model do
end
