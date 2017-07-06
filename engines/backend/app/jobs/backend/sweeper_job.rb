module Backend
  class SweeperJob < ApplicationJob
    def perform
      TimelineFragment.where.not(job_id: Job.processing).find_each do |record|
        record.delete
      end
    end
  end
end
