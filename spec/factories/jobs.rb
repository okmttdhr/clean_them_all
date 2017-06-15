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

FactoryGirl.define do
  factory :job do
    id                { Forgery(:basic).number(at_most: 10000000) }
    transition_state  { :processing }
    progression_state { :collecting }

    association :user
    association :parameter, factory: :job_parameter
  end
end
