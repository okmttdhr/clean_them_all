module UserReport
  extend ActiveSupport::Concern

  def report
    parameters  = {
      user_id: current_user.id,
      job_id: current_user.active_job.id,
      message: params[:message],
      allow_reply: !!params[:allow_reply] ? 'YES' : 'NO',
    }
    TD.event.post(:user_report, parameters)

    respond_to do |format|
      format.json { render json: { success: true }, status: 200 }
    end

  rescue => ex
    Airbrake.notify(ex)

    respond_to do |format|
      format.json { render json: { success: false }, status: 500 }
    end
  end
end
