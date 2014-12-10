class SessionsController < Devise::SessionsController

  def new
    add_breadcrumb '登录'
    super
  end

  def create
    super
    session[:user_id] = current_user.id
  end

  def destroy
    super
    session[:user_id] = nil
  end

end
