module Backend
  class ServiceLocator
    def self.service_for(job)
      case job.aasm(:progression).current_state
      when :collecting; CollectService.new(job)
      when :cleaning;   DestroyService.new(job)
      end
    end
  end
end
