hosts_using_original_gem = %w(CatMBP.local)
host = `hostname`.strip
if hosts_using_original_gem.include? host
  source 'https://rubygems.org'
else
  source 'https://ruby.taobao.org'
end

source 'https://rails-assets.org'
ruby '2.2.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.1'

# Settings
gem 'rails_config', '~> 0.4.2'

gem 'rails-bootstrap', '~> 3.0.0.4'
# gem 'sass-rails', '~> 4.0.3'
gem 'sass-rails', github: 'rails/sass-rails', branch: '4-0-stable'
gem 'coffee-rails', '~> 4.1.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails', '~> 3.1.2'
gem 'jbuilder', '~> 2.0'
gem 'turbolinks', '~> 2.3.0'
gem 'jquery-turbolinks', '~> 2.0.2'
gem 'bootstrap-sass', '~> 3.2.0.2'
# gem 'bootstrap_helper', '~> 4.2.3' # Removed for: https://ruby-china.org/topics/6720

gem 'bcrypt-ruby', '3.1.5'
# gem 'will_paginate', '3.0.4'
gem 'will_paginate-bootstrap', '1.0.1'
gem 'bootstrap-will_paginate', '0.0.9'
gem 'breadcrumbs_on_rails', '~> 2.3.0'

# Google, YouTube, and Medium like slim progress bars
gem 'nprogress-rails', '~> 0.1.6.3'

# Use postgresql as the database for Active Record
# gem 'mysql2', '~> 0.3.16'

gem 'pg', '~> 0.18.1'

# ActiveRecord or Migration support
# gem 'activerecord-mysql-unsigned', '~> 0.3.1'

# gem 'protected_attributes', '~> 1.0.8'
# There is many bugs in activerecord-mysql-unsigned, so don't use it
gem 'paranoia', '~> 2.0.2'

# api
# gem 'rails-api', '~> 0.4.0'
gem 'grape', '~> 0.11.0'
gem 'grape-entity', '~> 0.4.5'

# auth: use token
# gem 'doorkeeper', '~> 2.2.0'
# gem 'rack-oauth2', '~> 1.1.1'

# redis store for cache
gem 'redis-rails', '~> 4.0.0'

# redis-search
gem 'ruby-pinyin', '~> 0.4.3'
gem 'redis-search', '~> 0.9.7'
gem 'rails-assets-jquery-textcomplete', '~> 0.3.4'

# Markdown editor
gem 'rails-assets-simple-module', '~> 2.0.4'
gem 'rails-assets-simditor', '~> 2.0.3'
# HTML and CSS sanitizer
gem 'sanitize', '~> 3.0.3'

gem 'font-awesome-rails', '~> 4.3.0.0'

# Background Task
gem 'sidekiq', '~> 3.2.6'
# sidekiq - Monitoring
gem 'sinatra', '>= 1.3.0', :require => nil
# Scheduled Jobs
gem 'whenever', '~> 0.9.4', :require => false

# Forms
gem 'simple_form', '~> 3.1.0.rc2', github: 'plataformatec/simple_form', branch: 'master', ref: 'd49263a069b44b84d295a8c5e0debff2dd26a077' # 7abd871b520b24d10d676338801f49004398acd4
# gem 'simple_form'

# Friendly select box
gem 'chosen-rails', '~> 1.2.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'less-rails', '~> 2.7.0'
# gem 'therubyracer',  platforms: :ruby

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use puma as the app server
gem 'puma', '2.6.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# User System
gem 'devise', '~> 3.4.0'
# Authorization System
gem 'pundit', '~> 0.3.0'

# Third parties login
gem 'omniauth', '~> 1.2.2'
gem 'omniauth-oauth2', '~> 1.2.0'
gem 'omniauth-linkedin', '~> 0.2.0'
gem 'omniauth-weibo-oauth2', '~> 0.4.0'
gem 'omniauth-renren-oauth2', '~> 0.0.6'
# gem 'omniauth-qq-oauth2', :git => 'git://github.com/yeetim/omniauth-qq-oauth2.git', :ref => '054d6'
# gem 'omniauth-qq-oauth2', '0.4.0'

gem 'adminlte-rails', '~> 1.3.3'


group :development, :test do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rspec-rails', '2.13.1'
  gem 'ruby-debug-ide', '~> 0.4.22'
  gem 'debase'
  gem 'bullet', '~> 4.14.0'

  # Footnote for debug
  # gem 'rails-footnotes', '~> 4.1.4'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # TODO: use the following gems to combine social icons:
  # gem 'sprite-factory', '1.4.1', require: false
  # gem 'chunky_png', '1.2.8', require: false

  # campistrano
  gem 'capistrano', '~> 3.2.1'
  gem 'capistrano-rbenv', '~> 2.0.2'
  gem 'capistrano-rails', '~> 1.1.2'
  gem 'capistrano-bundler', '~> 1.1.3'
  gem 'capistrano3-puma', '~> 0.8.3'
  gem 'capistrano-sidekiq', '~> 0.3.8'
  gem 'capistrano-gulp', '~> 0.0.1'

end

group :production do
  # Monitoring
  gem 'newrelic_rpm'
end

group :test do
  gem 'minitest'
end

