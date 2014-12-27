class SessionsController < Devise::SessionsController

  def new
    add_breadcrumb '登录'
    super
  end

  def create
    # super
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?

    # super end

    session[:user_id] = current_user.id
    # generate login history

    redirect_to root_path
  end

  def destroy
    super
    session[:user_id] = nil
  end

end
