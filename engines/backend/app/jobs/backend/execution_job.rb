module Backend
  class ExecutionJob < ApplicationJob
    include Backend::Concerns::Services::Rescueable

    def perform(id)
      Job.find(id).tap do |job|
        @job = job
        ServiceLocator.service_for(job).try(:execute!)
      end
    end
  end
end
