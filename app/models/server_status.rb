class ServerStatus
  BUSYNESS_EMPTY  = :empty
  BUSYNESS_NORMAL = :normal
  BUSYNESS_JAM    = :jam
  BUSYNESS_HALT   = :halt

  def self.busyness_status
    [BUSYNESS_EMPTY, BUSYNESS_NORMAL, BUSYNESS_JAM, BUSYNESS_HALT]
  end

  def self.busyness
    max_duration = Time.now.to_i - (Job.processing.pluck(:updated_at).min || Time.now).to_i
    (max_duration < 1.minutes)  ? BUSYNESS_EMPTY  :
    (max_duration < 5.minutes)  ? BUSYNESS_NORMAL :
    (max_duration < 10.minutes) ? BUSYNESS_JAM
                                : BUSYNESS_HALT
  end

  def self.processing_job_count
    Job.processing.count
  end
end
