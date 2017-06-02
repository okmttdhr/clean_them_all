module Backend
  class CollectService
    include Backend::Concerns::Services::Collectable
    include Backend::Concerns::Services::Protectable

    attr_reader :job, :credentials, :collect_parameter, :protect_parameter

    def initialize(job)
      @job                = job
      @credentials        = CredentialParameter.from_job(job)
      @collect_parameter  = CollectParameter.from_job(job)
      @protect_parameter  = ProtectParameter.from_job(job)
    end

    def execute!
      ActiveRecord::Base.transaction do
        TimelineFragment.import_with_buffer do |buffer|
          collect do |status|
            next if protected_status?(status)
            buffer.add([status[:id], job.id])
          end
        end
        job.update! collect_count: TimelineFragment.where(job_id: job.id).count
        job.collect!
      end
    end
  end
end
