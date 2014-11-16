class UserProfileController < ApplicationController
  before_action :check_login

  def edit
    add_breadcrumb '个人中心'
    add_breadcrumb '修改资料'
    @current_user_profile = current_user.profile
  end

  def update
    flash[:success] = '资料修改成功。'
    current_user.user_profile.update(user_profile_params)
    redirect_to edit_user_profile_path
  end

  protected

  def user_profile_params
    params.require(:user_profile).permit(:name, :city, :website, :weibo, :introduction)
  end

end
