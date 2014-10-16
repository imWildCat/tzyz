class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  protected
  def check_login
    unless current_user
      flash[:warning] = '您必须登录后才能修改资料。'
      redirect_to new_user_session_path
    end

  end
end
