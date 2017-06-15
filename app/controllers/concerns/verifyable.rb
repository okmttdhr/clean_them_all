module Verifyable
  extend ActiveSupport::Concern

  included do
    before_action :user_should_be_authorized
    before_action :user_should_not_have_active_job, only:   [:info, :new, :create]
    before_action :user_should_have_active_job,     except: [:info, :new, :create, :upload]
    before_action :active_job_should_be_closing,    only:   [:destroy]
  end

  private

  def user_should_be_authorized
    redirect_to root_path, alert: '認証されていません。Twitterでログインしてください' if current_user.blank?
  end

  def user_should_not_have_active_job
    redirect_to cleaner_path if current_user.active_job.present?
  end

  def user_should_have_active_job
    redirect_to info_cleaner_path if current_user.active_job.blank?
  end

  def active_job_should_be_closing
    redirect_back unless current_user.active_job.closing?
  end

  def redirect_back
    case current_user.active_job.aasm(:transition).current_state
    when :processing, :confirming, :closing
      redirect_back_url = cleaner_path
    else
      redirect_back_url = root_path
    end
    redirect_to redirect_back_url
  end
end
