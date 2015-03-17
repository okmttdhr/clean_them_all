class Service::ServicesController < ApplicationController
  def health
    @health = [
      Job.cleaning.count + Job.fetching.count < 20,
    ].all?
    @status = @health ? 200 : 500

    respond_to do |format|
      format.html { render json: { success: @health }, status: @status }
    end
  end
end
