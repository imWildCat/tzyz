redis_server = Rails.application.secrets.redis_server
redis_port = Rails.application.secrets.redis_port
redis_db_num = Rails.application.secrets.redis_db_num
redis_namespace_prefix = Rails.application.secrets.redis_namespace_prefix

Sidekiq.configure_server do |config|
  p redis_server
  config.redis = {url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}", namespace: redis_namespace_prefix +
      'sq'}
end

Sidekiq.configure_client do |config|
  config.redis = {url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}", namespace: redis_namespace_prefix + 'sq'}
end

# Sidekiq::Logging.logger = Log4r::Logger.new 'sidekiq'
# Sidekiq::Logging.logger.level = Log4r::Info