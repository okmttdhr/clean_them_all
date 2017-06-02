class CleanerStatus
  attr_reader :job, :server_status

  def initialize(job, server_status)
    @job, @server_status = job, server_status
  end

  def props
    {
      progress_bar: {
        state_message: job.state_message,
        value:         job.progression_bar_width,
      },
      operation: {
        abortable:   job.processing?,
        confirmable: job.confirming?,
      },
      modal: {
        server: {
          busyness:             server_status.busyness,
          busyness_message:     server_status.busyness_message,
          processing_job_count: server_status.processing_job_count,
        },
        job: {
          collect_count: job.collect_count,
          destroy_count: job.destroy_count,
        },
        job_params: {
          user_name:        job.user.name,
          from:             job.parameter.collect_from,
          to:               job.parameter.collect_to,
          protect_reply:    job.parameter.protect_reply,
          protect_favorite: job.parameter.protect_favorite,
          created_at:       job.created_at.to_s(:db),
        },
      },
    }
  end
end
