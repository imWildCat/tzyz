class HotTopicsWorker
  include Sidekiq::Worker

  sidekiq_options :queue => :statistics, :retry => 5

  def perform
    logger.info('HotTopicsWorker')

    hot_topics = Topic.where('created_at > ?', 7.days.ago).where('reply_count > ?', 0).includes(:author, :refresher, :node)
                     .order(reply_count: :desc).limit(5).to_a

    Rails.cache.write('hot_topics', hot_topics)
  end

end
