class TzyzApiV1 < Grape::API

  prefix 'api'
  format :json
  version :v1

  helpers APIV1::Helpers

  content_type :json, 'application/json;charset=utf8'

  before do
    notification_count = 0
    if current_user
      notification_count = current_user.unread_notifications_count
    end
    header 'n_count', notification_count
  end

  mount APIV1::Accounts
  mount APIV1::Users
  mount APIV1::Nodes
  mount APIV1::NodeCategories
  mount APIV1::Notifications

  mount APIV1::Topics
  mount APIV1::Site


end