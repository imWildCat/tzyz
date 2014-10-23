class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_action :store_location

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
      flash[:warning] = '您必须登录后才能修改资料。'
      redirect_to new_user_session_path
    end
  end

  private
  def store_location
    if (request.path != new_user_session_path &&
        request.path != new_user_registration_path &&
        request.path != new_user_password_path &&
        request.path != edit_user_password_path &&
        request.path != user_confirmation_path &&
        request.path != new_user_confirmation_path &&
        request.path != destroy_user_session_path &&
        !request.xhr?)
      store_location_for(:user, request.fullpath)
    end
  end

end
