class NotificationsController < ApplicationController
  before_action :check_login

  def show
    # Get notifications of current user
    @notifications = current_user.notifications.order('is_read ASC').order('id DESC')

    # Set them read
    @ids = []
    @notifications.each do |n|
      @ids.append(n.id)
    end
    Notification.where(:id => @ids).update_all(is_read:true)

    # Clear cache
    current_user.clear_cached_notifications
  end

  def destroy

  end
end
