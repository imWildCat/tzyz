#! /usr/bin/env ruby
# scripts/sidekiq_pusher.rb
# bundle exec scripts/sidekiq_pusher.rb Warehouse::FtpPull
klass = ARGV[0]
require 'sidekiq'
Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://...' }
end
Sidekiq::Client.push('class' => klass, 'args' => [])