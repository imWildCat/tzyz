class NotificationsController < ApplicationController
  before_action :check_login

  include ApplicationHelper

  def show
    add_breadcrumb '个人中心'
    add_breadcrumb '系统通知'
    # Get notifications of current user
    @notifications = current_user.unread_notifications(current_page)

    # # Set them read
    # @ids = []
    # @notifications.each do |n|
    #   @ids.append(n.id)
    # end
    # Notification.where(:id => @ids).update_all(is_read:true)
    #
    # # Clear cache
    # current_user.clear_cached_notifications
  end

  def destroy

  end
end
