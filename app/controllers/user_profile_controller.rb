class UserProfileController < ApplicationController
  before_action :check_login, :check_profile

  def edit
    @current_user_profile = current_user.user_profile
  end

  def update
    flash[:success] = '资料修改成功。'
    current_user.user_profile.update(user_profile_params)
    redirect_to edit_user_profile_path
  end

  protected
  def check_profile
    unless current_user.user_profile
      current_user.create_user_profile.save
    end
  end

  def user_profile_params
    params.require(:user_profile).permit(:name, :city)
  end

end
