require "#{Rails.root}/app/omniauth/strategies/qq"
Rails.application.config.middleware.use OmniAuth::Builder do

  provider :developer unless Rails.env.production?
  provider :qq_connect, Rails.application.secrets.qq_connect_app_key, Rails.application.secrets.qq_connect_secret_key, scope: 'get_user_info, add_share', :provider_ignores_state => true
  provider :linkedin, Rails.application.secrets.linkedin_app_key, Rails.application.secrets.linkedin_secret_key, :provider_ignores_state => true
  provider :renren, Rails.application.secrets.renren_app_key, Rails.application.secrets.renren_secret_key, :provider_ignores_state => true
  provider :weibo, Rails.application.secrets.weibo_app_key, Rails.application.secrets.weibo_secret_key, :provider_ignores_state => true

end