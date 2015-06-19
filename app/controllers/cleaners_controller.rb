class CleanersController < ApplicationController
  include CleanStatus
  include FileUpload

  ############################################################################
  before_action :user_should_be_authorized,       except: [:getstarted]
  before_action :user_should_not_have_active_job, only:   [:info, :new, :create]
  before_action :user_should_have_active_job,     except: [:getstarted, :info, :new, :create]
  before_action :active_job_should_be_inprogress, only:   [:status]
  before_action :active_job_should_be_processing, only:   [:abort]
  before_action :active_job_should_be_confirming, only:   [:confirm]
  before_action :active_job_should_be_closing,    only:   [:result, :destroy]

  before_action :sync_progression, only: :status

  ############################################################################

  def getstarted
    respond_to do |format|
      format.html
    end
  end

  def info
    respond_to do |format|
      format.html
    end
  end

  def show
    redirect_to getstarted_cleaner_path
  end

  ############################################################################

  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    Job.create! do |job|
      job.build_parameter
      job.user_id           = current_user.id
      job.parameter.extras  = session[:extras]
      job.parameter.options = params[:options]
    end

    respond_to do |format|
      format.html { redirect_to status_cleaner_path }
    end
  end

  ############################################################################

  def status
    @status = CleanStatusDecorator.decorate(current_status)

    respond_to do |format|
      format.html { @status }
      format.json { render json: @status.object }
    end
  end

  def abort
    current_user.active_job.abort! if current_user.active_job.may_abort?

    respond_to do |format|
      format.html { redirect_to status_cleaner_path }
    end
  end

  def confirm
    current_user.active_job.confirm!

    respond_to do |format|
      format.html { redirect_to result_cleaner_path }
    end
  end

  ############################################################################

  def result
    @status = CleanStatusDecorator.decorate(current_status)

    respond_to do |format|
      format.html { @status }
    end
  end

  def destroy
    current_user.active_job.close!

    respond_to do |format|
      format.html { redirect_to signout_path }
    end
  end

  protected

  def sync_progression
    return unless current_user.active_job.may_finish?
    if current_user.active_job.progression.current_state == :finished
      current_user.active_job.finish!
    end
  end

  protected

  def user_should_be_authorized
    redirect_to getstarted_cleaner_path unless current_user.present?
  end

  def user_should_not_have_active_job
    redirect_to status_cleaner_path if current_user.has_active_job?
  end

  def user_should_have_active_job
    redirect_to new_cleaner_path unless current_user.has_active_job?
  end

  def active_job_should_be_inprogress
    redirect_back unless current_user.active_job.inprogress?
  end

  def active_job_should_be_processing
    redirect_back unless current_user.active_job.processing?
  end

  def active_job_should_be_confirming
    redirect_back unless current_user.active_job.confirming?
  end

  def active_job_should_be_closing
    redirect_back unless current_user.active_job.closing?
  end

  def redirect_back
    case current_user.active_job.aasm.current_state
    when :processing
      redirect_back_url = status_cleaner_path
    when :confirming
      redirect_back_url = status_cleaner_path
    when :closing
      redirect_back_url = result_cleaner_path
    else
      redirect_back_url = root_path
    end
    redirect_to redirect_back_url
  end
end
