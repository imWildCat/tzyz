class TzyzApiV1 < Grape::API
  prefix 'api'
  format :json
  version :v1

  helpers APIV1::Helpers

  content_type :json, 'application/json;charset=utf8'

  mount APIV1::Users
  mount APIV1::Topics


end