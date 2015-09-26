module CleanStatus
  extend ActiveSupport::Concern

  protected

  def current_status
    Hashie::Mash.new({
      job: {
        current_state: current_user.active_job.aasm.current_state.to_s,
        created_at:    current_user.active_job.created_at,
      },
      progression: {
        current_state:   current_user.active_job.progression.aasm.current_state,
        statuses_count:  current_user.active_job.progression.filter_count,
        destroyed_count: current_user.active_job.progression.destroy_count,
        created_at:      current_user.active_job.progression.created_at,
        updated_at:      current_user.active_job.progression.updated_at,
      },
      parameters: {
        name:             current_user.name,
        posted_from:      current_user.active_job.parameter.collect_from,
        posted_to:        current_user.active_job.parameter.collect_to,
        protect_reply:    current_user.active_job.parameter.protect_reply?,
        protect_favorite: current_user.active_job.parameter.protect_favorite?,
      },
      server_status: {
        busyness:             ServerStatus.busyness,
        processing_job_count: ServerStatus.processing_job_count,
      },
    })
  end
end
