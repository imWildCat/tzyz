require "#{Rails.root}/app/omniauth/strategies/qq"
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :qq_connect, Rails.application.secrets.qq_connect_app_key, Rails.application.secrets.qq_connect_secret_key, scope: 'get_user_info,add_share', :provider_ignores_state => true
end