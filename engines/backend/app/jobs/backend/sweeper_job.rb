module Backend
  class SweeperJob < ApplicationJob
    def perform
      TimelineFragment.where.not(job_id: Job.processing).delete_all
    end
  end
end

