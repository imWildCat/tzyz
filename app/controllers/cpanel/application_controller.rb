class Cpanel::ApplicationController < ApplicationController
  layout 'cpanel'
  before_filter :require_admin
  before_filter :set_active_menu

  def require_admin

  end
  
  def set_active_menu
  end
  
end
