class ServerStatus
  BUSYNESS_EMPTY  = :empty
  BUSYNESS_NORMAL = :normal
  BUSYNESS_JAM    = :jam
  BUSYNESS_HALT   = :halt

  def self.busyness_status
    [BUSYNESS_EMPTY, BUSYNESS_NORMAL, BUSYNESS_JAM, BUSYNESS_HALT]
  end

  def self.busyness
    processing = Job.processing.count
    (processing <= 40)  ? BUSYNESS_EMPTY  :
    (processing <= 80)  ? BUSYNESS_NORMAL :
    (processing <= 240) ? BUSYNESS_JAM
                       : BUSYNESS_HALT
  end

  def self.processing_job_count
    Job.processing.count
  end
end
