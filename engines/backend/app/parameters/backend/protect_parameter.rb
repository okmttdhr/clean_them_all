module Backend
  class ProtectParameter
    attr_accessor :signedin_at, :registered_at, :protect_reply, :protect_favorite,
                  :collect_from, :collect_to

    def self.from_job(job)
      ProtectParameter.new.tap do |obj|
        obj.signedin_at      = job.parameter.signedin_at
        obj.registered_at    = job.parameter.registered_at
        obj.protect_reply    = job.parameter.protect_reply
        obj.protect_favorite = job.parameter.protect_favorite
        obj.collect_from     = job.parameter.collect_from
        obj.collect_to       = job.parameter.collect_to
      end
    end
  end
end
