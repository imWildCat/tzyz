job_type :job, 'cd :path && :environment_variable=:environment bundle exec script/sidekiq_pusher.rb :task :output'
every 1.day, :at => ['8:00 am', '12:00 pm', '16:00 pm', '20:00 pm'] do
  job 'HotNodesWorker'
end