class SessionsController < Devise::SessionsController

  def new
    add_breadcrumb '登录'
    super
  end

  def create
    super
    session[:user_id] = current_user.id
    # generate login history
    UserLoginHistory.create user_id: current_user.id, ip: request.remote_ip
  end

  def destroy
    super
    session[:user_id] = nil
  end

end
