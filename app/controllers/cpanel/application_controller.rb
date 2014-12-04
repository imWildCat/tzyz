class Cpanel::ApplicationController < ApplicationController
  include CpanelHelper

  layout 'cpanel'
  before_filter :require_admin, :check_login
  before_filter :set_active_menu

  def require_admin

  end
  
  def set_active_menu
  end
  
end
