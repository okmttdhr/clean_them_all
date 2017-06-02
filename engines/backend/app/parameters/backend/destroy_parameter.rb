module Backend
  class DestroyParameter
    attr_accessor :start_message, :finish_message

    def self.from_job(job)
      DestroyParameter.new.tap do |obj|
        obj.start_message  = job.parameter.start_message
        obj.finish_message = job.parameter.finish_message
      end
    end
  end
end
