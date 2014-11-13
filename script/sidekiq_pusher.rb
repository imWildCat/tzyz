#! /usr/bin/env ruby
# script/sidekiq_pusher.rb
# bundle exec script/sidekiq_pusher.rb Warehouse::FtpPull
# You might have to modify this file on production mode: to change the redis config which cannot load from
# configuration of Rails.

klass = ARGV[0]
require 'sidekiq'
Sidekiq.configure_client do |config|
  config.redis = {url: 'redis://localhost:6379/6', namespace: 'tzyz_sq'}
end
Sidekiq::Client.push('class' => klass, 'args' => [])