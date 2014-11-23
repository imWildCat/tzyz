#source 'https://rubygems.org'
source 'https://ruby.taobao.org'
source 'https://rails-assets.org'
ruby '2.1.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'

# Settings
gem 'rails_config', '~> 0.4.2'

gem 'rails-bootstrap', '~> 3.0.0.4'
gem 'sass-rails', '~> 4.0.3'
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

# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.3.16'

# gem 'protected_attributes', '~> 1.0.8'
# There is many bugs in activerecord-mysql-unsigned, so don't use it
gem 'paranoia', '~> 2.0.2'

# redis store for cache
gem 'redis-rails', '~> 4.0.0'

# Markdown editor
gem 'codemirror-rails', '~> 4.8'
# Markdown parser
gem 'rails-assets-remarkable'

# Background Task
gem 'sidekiq', '~> 3.2.6'
# sidekiq - Monitoring
gem 'sinatra', '>= 1.3.0', :require => nil
# Scheduled Jobs
gem 'whenever', '~> 0.9.4', :require => false

# Forms
gem 'simple_form', '~> 3.1.0.rc2', github: 'plataformatec/simple_form', branch: 'master'
# gem 'simple_form'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby


# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc


# Use puma as the app server
gem 'puma', '2.6.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# User System
gem 'devise', '~> 3.4.0'
# RBAC
gem 'cancan', '~> 1.6.10'

group :development, :test do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rspec-rails', '2.13.1'
  gem 'ruby-debug-ide', '~> 0.4.22'
  gem 'debase'

  gem 'capistrano', '~> 3.2.1'
  gem 'capistrano-rbenv', '~> 2.0.2'
  gem 'capistrano-rails', '~> 1.1.2'
  gem 'capistrano-bundler', '~> 1.1.3'
  gem 'capistrano3-puma', '~> 0.8.3'
  gem 'capistrano-sidekiq', '~> 0.3.8'

end

group :production do
  # Monitoring
  gem 'newrelic_rpm'
end

group :test do
  gem 'minitest'
end

