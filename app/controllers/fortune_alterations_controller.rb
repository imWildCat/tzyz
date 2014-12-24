class FortuneAlterationsController < ApplicationController
  include ApplicationHelper

  before_action :check_login

  def show
    @fortune_alterations = current_user.recent_fortune_alterations(current_page)

    add_breadcrumb '个人中心'
    add_breadcrumb '账户余额'
  end

  def daily_award
    alteration = current_user.perform_daily_award
    if alteration
      flash[:info] = "您获得了 #{alteration.quantity} 铜币的每日登录奖励。"
    else
      flash[:warning] = '您已经领取过每日登录奖励了。'
    end
    redirect_to root_path
  end
end
