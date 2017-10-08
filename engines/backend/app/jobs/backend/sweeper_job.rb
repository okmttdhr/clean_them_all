module Backend
  class SweeperJob < ApplicationJob
    def perform
      TimelineFragment.where.not(job_id: Job.processing).limit(3200).pluck(:id).each do |id|
        TimelineFragment.delete(id)
      end
      # FIXME: 進捗状態が更新されない原因を突き止める
      Job.cleaning.where(transition_state: [:confirming, :closing, :closed]).update_all(progression_state: :aborted)
    end
  end
end
