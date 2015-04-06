job_type :job, 'cd :path && :environment_variable=:environment bundle exec script/sidekiq_pusher.rb :task :output'

every 1.day, :at => ['8:00 am', '12:00 pm', '16:00 pm', '20:00 pm'] do
  job 'HotNodesWorker'
end

every 1.day, :at => ['8:30 am', '12:30 pm', '16:30 pm', '20:30 pm'] do
  job 'HotTopicsWorker'
end

# Backup
# TODO: migrate to pgsql
# every 1.day, :at => ['1:30 am', '1:30 pm'] do
#   command 'backup perform -t tzyz'
# end