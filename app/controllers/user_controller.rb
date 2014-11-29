class UserController < ApplicationController
  include ApplicationHelper
  before_action :check_login, only: [:show]

  def show
    id = params[:id]
    @user = User.find(id)
    @topics = @user.recent_topics(1, 3)
    @replies = @user.recent_replies(1, 3)

    add_breadcrumb '查看用户'
    add_breadcrumb @user.nickname
  end

  def topics
    id = params[:id]
    page = current_page
    @user = User.find(id)
    @topics = @user.recent_topics(page)

    add_breadcrumb '查看用户'
    add_breadcrumb @user.nickname, user_path(@user)
    add_breadcrumb "话题列表 ( #{page} )"
  end

  def replies
    id = params[:id]
    page = current_page
    @user = User.find(id)
    @replies = @user.recent_replies(page)

    add_breadcrumb '查看用户'
    add_breadcrumb @user.nickname, user_path(@user)
    add_breadcrumb "回复列表 ( #{page} )"
  end

end
