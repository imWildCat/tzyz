require 'redis'
require 'redis-namespace'
require 'redis-search'

redis_server = Rails.application.secrets.redis_server
redis_port = Rails.application.secrets.redis_port
redis_db_num = Rails.application.secrets.redis_db_num
redis_namespace_prefix = Rails.application.secrets.redis_namespace_prefix

# don't forget change namespace
redis = Redis.new(:host => redis_server, :port => redis_port)
# We suggest you use a special db in Redis, when you need to clear all data, you can use flushdb command to clear them.
redis.select(redis_db_num)
# Give a special namespace as prefix for Redis key, when your have more than one project used redis-search, this config will make them work fine.
redis = Redis::Namespace.new("#{redis_namespace_prefix}search", :redis => redis)
Redis::Search.configure do |config|
  config.redis = redis
  config.complete_max_length = 100
  config.pinyin_match = true
  # use rmmseg, true to disable it, it can save memroy
  config.disable_rmmseg = false
end