class SessionsController < ApplicationController
  ##############################################################################
  rescue_from Exception, with: :session_exception

  ##############################################################################

  def failure
    reset_session

    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end

  ##############################################################################

  def create
    auth = request.env['omniauth.auth']

    user = User.find_or_create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:extras]  = extras_for(auth)

    respond_to do |format|
      format.html { redirect_to info_cleaner_path }
    end
  end

  ##############################################################################

  def destroy
    reset_session

    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end

  ##############################################################################

  private

  def session_exception(ex)
    reset_session
    raise ex
  end

  ##############################################################################

  protected

  def extras_for(auth)
    { signedin_at: signedin_at(auth),
      statuses_count: statuses_count(auth),
      registered_at: registered_at(auth) }
  end

  def signedin_at(auth)
    DateTime.now
  end

  def statuses_count(auth)
    auth[:extra][:raw_info][:statuses_count].presence || 3200
  rescue
    3200
  end

  def registered_at(auth)
    Time.parse(auth[:extra][:raw_info][:created_at]).to_datetime.to_s
  rescue
    DateTime.new(2006, 1, 1)
  end
end
