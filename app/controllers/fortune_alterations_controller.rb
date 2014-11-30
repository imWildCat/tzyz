class FortuneAlterationsController < ApplicationController
  include ApplicationHelper

  before_action :check_login

  def show
    @fortune_alterations = current_user.recent_fortune_alterations(current_page)

    add_breadcrumb '个人中心'
    add_breadcrumb '账户余额'
  end
end
