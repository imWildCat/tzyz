class QuickSearchController < ApplicationController
  before_action :check_login

  include ApplicationHelper

  def u
    render :json => Redis::Search.query('User', params[:q])
  end


end
