module Backend
  class CollectParameter
    attr_accessor :collect_method, :archive_url

    def self.from_job(job)
      CollectParameter.new.tap do |obj|
        obj.collect_method = job.parameter.collect_method.to_sym
        obj.archive_url    = job.parameter.archive_url
      end
    end
  end
end
