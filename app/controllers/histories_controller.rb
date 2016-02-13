class HistoriesController < ApplicationController
  before_action :user_should_be_authorized

  def show
    job = current_user.jobs.histories.find(params[:id])
    @timeline = DarkHistory.open(job.id, params[:page].to_i)

    respond_to do |format|
      format.html
    end
  end

  private

  def user_should_be_authorized
    redirect_to getstarted_cleaner_path unless current_user.present?
  end
end
