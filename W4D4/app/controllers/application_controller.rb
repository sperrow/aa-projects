class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :owned_cat?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!(user)
    session[:session_token] = user.reset_session_token!
    redirect_to cats_url
  end

  def logged_in?
    !!current_user
  end

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def require_logged_out
    redirect_to cats_url if logged_in?
  end

  def require_owned_cat
    redirect_to cats_url unless current_user.cats.exists?(id: params[:id])
  end

  def owned_cat?
    current_user.cats.exists?(id: params[:id])
  end

end
