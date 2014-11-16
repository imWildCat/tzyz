class HotTopicsWorker
  include Sidekiq::Worker

  sidekiq_options :queue => :statistics, :retry => 5

  def perform
    logger.info('HotTopicsWorker')

    @hot_topics = Topic.where('created_at > ?', 7.days.ago).order(replies_count: :desc).select('id, title').limit(7)

    Rails.cache.write('hot_topics', @hot_topics)
  end

end
