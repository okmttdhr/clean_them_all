class SessionsController < ApplicationController
  rescue_from Exception, with: :invalid_session_exception

  def create
    user = User.find_or_create_with_omniauth(auth_hash)
    session[:user_id] = user.id
    session[:extras]  = extras_for(auth_hash)
    redirect_to info_cleaner_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def failure
    reset_session
    redirect_to root_path, alert: '認証が正しく行われませんでした'
  end

  protected

  def invalid_session_exception(ex)
    reset_session
    raise ex
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  def extras_for(auth)
    {
      signedin_at:    signedin_at(auth),
      statuses_count: statuses_count(auth),
      registered_at:  registered_at(auth),
    }
  end

  def signedin_at(auth)
    DateTime.current
  end

  def statuses_count(auth)
    auth.dig(:extra, :raw_info, :statuses_count) || 3200
  end

  def registered_at(auth)
    auth.dig(:extra, :raw_info, :created_at).try(:in_time_zone) || Time.zone.local(2006, 1, 1)
  end
end
