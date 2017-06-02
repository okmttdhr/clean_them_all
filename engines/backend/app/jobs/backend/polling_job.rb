module Backend
  class PollingJob < ApplicationJob
    def perform
      Job.processing.pluck(:id).each do |job_id|
        ExecutionJob.perform_later job_id
      end
    end
  end
end

