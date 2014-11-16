class SessionsController < Devise::SessionsController

  def new
    add_breadcrumb '登录'
    super
  end

end
