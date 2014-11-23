class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :force_ssl_request
  after_action :store_location

  add_breadcrumb '首页', :root_path

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def after_sign_in_path_for(resource_or_scope)
    session[:user_return_to] || root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  protected
  def check_login
    unless current_user
      flash[:warning] = '您必须登录后才能继续。'
      redirect_to new_user_session_path
    end
  end

  def force_ssl_request
    if request.ssl? or Rails.env.development? or request.post?
      return true
    elsif current_user or force_ssl_path?
      force_ssl_redirect
      # redirect_to url_for params.merge({:protocol => 'https://'})
      return false
    end
  end

  private
  def store_location
    if (request.path != new_user_session_path and
        request.path != new_user_registration_path and
        request.path != new_user_password_path and
        request.path != edit_user_password_path and
        request.path != user_confirmation_path and
        request.path != new_user_confirmation_path and
        request.path != destroy_user_session_path and
        !request.xhr? and
        !request.post?)
      store_location_for(:user, request.fullpath)
    end
  end

  def force_ssl_path?
    request.path == new_user_session_path or request.path == user_registration_path or
        request.path == new_user_unlock_path or request.path == new_user_confirmation_path
  end

end
