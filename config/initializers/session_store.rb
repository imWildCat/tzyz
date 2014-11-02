# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cache_store, key: 'session'

# Rails.application.config.session_store = :redis_store #, {
# :host => Rails.application.secrets.redis_server,
# :port => Rails.application.secrets.redis_port,
# :db => 99,
# :namespace => Rails.application.secrets.redis_namespace_prefix + 'session'}
# Tzyz::Application.config.session_store = :redis_store, {
#     :host => Rails.application.secrets.redis_server,
#     :port => Rails.application.secrets.redis_port,
#     :db => 99,
#     :namespace => Rails.application.secrets.redis_namespace_prefix + 'session'}