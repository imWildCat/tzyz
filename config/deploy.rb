# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'tzyz'
set :repo_url, 'git://github.com/imWildCat/tzyz.git'

set :rbenv_ruby, '2.1.3'

# Default branch is :master

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/server_admin/tzyz_production/'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/application.yml config/secrets.yml config/newrelic.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploadsexample}

# Default value for default_env is {}
# set :default_env, { path: '$HOME/.rbenv/shims/:$PATH' }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Whenever
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :worker do

  desc 'Run Hot Nodes worker'
  task :hot_nodes do
    on roles(:app) do
      # TODO: `bundle exec...` would lead to an error. Find why
      execute "cd #{deploy_to}current; ~/.rbenv/shims/bundle exec script/sidekiq_pusher.rb HotNodesWorker"
    end
  end

  desc 'Run Hot Topics worker'
  task :hot_topics do
    on roles(:app) do
      execute "cd #{deploy_to}current; ~/.rbenv/shims/bundle exec script/sidekiq_pusher.r HotTopicsWorker"
    end
  end

end

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 1 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart do
    invoke 'worker:hot_nodes'
    invoke 'worker:hot_topics'
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  # after :publishing do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     # execute :rake, 'db:seed'
  #     # end
  #   end
  # end

end
