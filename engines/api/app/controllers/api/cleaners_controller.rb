module Api
  class CleanersController < ApplicationController
    def show
      @job           = current_user.active_job
      @server_status = ServerStatus.current_server_status
    end
  end
end
