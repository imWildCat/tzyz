class UserProfileController < ApplicationController
  before_action :check_login

  def edit
    add_breadcrumb '个人中心'
    add_breadcrumb '修改资料'
    @current_user_profile = current_user.profile
    @authorizations = current_user.authorizations
  end

  def update
    profile_data = user_profile_params

    unless profile_data.nil?
      unless profile_data[:gender] == 'true' or profile_data[:gender] == 'false'
        profile_data[:gender] = nil
      end
    end

    puts profile_data
    current_user.user_profile.update(profile_data)
    flash[:success] = '资料修改成功。'
    redirect_to edit_user_profile_path
  end

  protected

  def user_profile_params
    params.require(:user_profile).permit(:name, :gender, :headline, :field, :university, :company, :city, :website,
                                         :email, :qq, :weibo, :wechat, :linkedin, :zhihu, :douban, :renren,
                                         :introduction)
  end

end
