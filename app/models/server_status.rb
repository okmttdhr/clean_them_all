class ServerStatus
  BUSYNESS_EMPTY  = :empty
  BUSYNESS_NORMAL = :normal
  BUSYNESS_JAM    = :jam
  BUSYNESS_HALT   = :halt

  attr_accessor :busyness, :processing_job_count

  class << self
    def current_server_status
      ServerStatus.new.tap do |status|
        status.busyness             = busyness
        status.processing_job_count = processing_job_count
      end
    end

    def processing_job_count
      Job.processing.count
    end

    def busyness
      processing_job_count.try do |count|
        (count <= 25)  ? BUSYNESS_EMPTY  :
        (count <= 50)  ? BUSYNESS_NORMAL :
        (count <= 100) ? BUSYNESS_JAM
                       : BUSYNESS_HALT
      end
    end

    def busyness_status
      [BUSYNESS_EMPTY, BUSYNESS_NORMAL, BUSYNESS_JAM, BUSYNESS_HALT]
    end
  end
end
