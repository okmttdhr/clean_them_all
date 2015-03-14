class ErrorsController < ApplicationController
  layout false

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :status => 404 }
    end
  end

  def render_500(ex = env['action_dispatch.exception'])
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/500", :status => 500 }
    end
  end
end
