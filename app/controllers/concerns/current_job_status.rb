module CurrentJobStatus
  extend ActiveSupport::Concern

  protected

  def current_status
    {
      # server status
      busyness: ServerStatus.busyness,
      processing_job_count: ServerStatus.processing_job_count,
      # job stats
      job_state: current_user.active_job.progression.aasm.current_state,
      statuses_count: 0, # TODO: 実装する
      destroyed_count: 0,
      failed_count: 0,
      # parameters
      name: current_user.name,
      posted_from: current_user.active_job.parameter.collect_from.try(:to_date),
      posted_to: current_user.active_job.parameter.collect_to.try(:to_date),
      protect_reply: current_user.active_job.parameter.protect_reply,
      protect_favorite: current_user.active_job.parameter.protect_favorite,
      created_at: current_user.active_job.created_at,
    }
  end
end
