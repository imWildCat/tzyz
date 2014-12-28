class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    user, authorization = User.from_omniauth(env['omniauth.auth'], current_user)
    kind = User::SOCIALS[params[:action].to_sym]
    if user != nil and user.persisted?
      sign_in user
      session[:user_id] = user.id


      # sign_in user would't call the following method, so call it manually
      user.after_database_authentication

      if user.sign_in_count == 1
        flash[:success] = "您的帐号现已关联 #{kind} 。"
        redirect_to root_path
      # els
      # if authorization.user_id == user.id
      #   flash[:success] = "您的帐号现已关联 #{kind} ，今后您可以通过 #{kind} 登录。"
      #   redirect_to root_path
      else
        flash[:success] = "您已成功通过 #{kind} 登录，欢迎回来。"
        redirect_to root_path
      end
    else
      session['devise.user_attributes'] = user.attributes
      session[:auth_id] = authorization.id
      flash[:info] = "没有找到与此 #{kind} 关联的帐号，请您完善注册信息。若您已有帐号，可以通过 Email 登录。"
      redirect_to new_user_registration_url
    end
  end


  User::SOCIALS.each do |k, _|
    alias_method k, :all
  end


end