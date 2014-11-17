class UserController < ApplicationController

  before_action :check_login, only: [:show]

  def show
    id = params[:id]
    @user = User.find(id)

    add_breadcrumb '查看用户'
    add_breadcrumb @user.nickname
  end
end
