module CurrentJobStatus
  extend ActiveSupport::Concern

  protected

  def current_status
    Hashie::Mash.new.tap do |status|
      # server status
      status.busyness             = ServerStatus.busyness
      status.processing_job_count = ServerStatus.processing_job_count
      # job stats
      status.job_state            = current_user.active_job.progression.aasm.current_state
      status.statuses_count       = 0 # TODO: 実装する
      status.destroyed_count      = 0 # TODO: 実装する
      status.failed_count         = 0 # TODO: 実装する
      # parameters
      status.name             = current_user.name
      status.posted_from      = current_user.active_job.parameter.collect_from.try(:to_date)
      status.posted_to        = current_user.active_job.parameter.collect_to.try(:to_date)
      status.protect_reply    = current_user.active_job.parameter.protect_reply?
      status.protect_favorite = current_user.active_job.parameter.protect_favorite?
      status.created_at       = current_user.active_job.created_at
    end
  end
end
