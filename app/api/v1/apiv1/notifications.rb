module APIV1
  class Notifications < Grape::API

    desc 'notifications list'
    resources :notifications do
      get :list do
        authenticate!
        # TODO: the order might be confusing
        notifications = current_user.unread_notifications(current_page)
        page_headers! notifications
        present notifications, with: Entities::Notification
      end
    end
  end
end