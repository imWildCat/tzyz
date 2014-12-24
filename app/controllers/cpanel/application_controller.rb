class Cpanel::ApplicationController < ApplicationController
  include CpanelHelper

  layout 'cpanel'
  before_filter :require_admin, :check_login
  before_filter :set_active_menu

  def require_admin
    unless current_user.admin?
      flash[:warning] = '您不是管理员，无权访问管理后台。'
      redirect_to root_path
    end
  end
  
  def set_active_menu
  end
  
end
