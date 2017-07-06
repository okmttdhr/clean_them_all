class CleanersController < ApplicationController
  include Verifyable

  def info; end
  def new; end

  def create
    ActiveRecord::Base.transaction do
      Job.new.tap do |job|
        job.build_parameter
        job.user_id              = current_user.id
        job.parameter.attributes = permitted_job_params
        job.save!
      end
    end
    redirect_to cleaner_path
  end

  def show
    @job           = current_user.active_job
    @server_status = ServerStatus.current_server_status

    case @job.aasm(:transition).current_state
    when :processing; render :status
    when :confirming; render :status
    when :closing;    render :result
    end
  end

  def upload
    presigned_url = TwitterArchive.new(params[:qqfile]).try do |file|
      file.store_file
      file.create_presigned_url
    end
    render json: { success: true, presigned_url: presigned_url }
  end

  def abort
    current_user.active_job.try do |job|
      job.abort! if job.may_abort?
    end
    redirect_to cleaner_path
  end

  def confirm
    current_user.active_job.try do |job|
      job.confirm! if job.may_confirm?
    end
    redirect_to cleaner_path
  end

  def destroy
    current_user.active_job.try do |job|
      job.close! if job.may_close?
    end
    reset_session
    redirect_to getstarted_path
  end

  private

  def permitted_job_params
    options = params.require(:job_parameter).permit(:collect_method, :archive_url, :protect_reply, :protect_favorite, :collect_from, :collect_to, :start_message, :finish_message)
    extras  = session[:extras].symbolize_keys.slice(:signedin_at, :statuses_count, :registered_at)
    options.merge(extras)
  end
end
