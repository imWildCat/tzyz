module APIV1
  class Notifications < Grape::API

    desc 'notifications list'
    resources :notifications do
      get :list do
        authenticate!
        # TODO: the order might be confusing
        present current_user.unread_notifications(current_page), with: Entities::Notification
      end
    end
  end
end