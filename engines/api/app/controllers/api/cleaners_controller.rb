module Api
  class CleanersController < ApplicationController
    before_action :user_should_be_authorized
    before_action :user_should_have_active_job

    def show
      @job           = current_user.active_job
      @server_status = ServerStatus.current_server_status
    end

    private

    def user_should_be_authorized
      head :bad_request if current_user.blank?
    end

    def user_should_have_active_job
      head :bad_request if current_user.active_job.blank?
    end
  end
end
