class FavoriteTopic < ActiveRecord::Base
  after_save :delete_cache_key, :refresh_topic_count
  after_destroy :delete_cache_key, :refresh_topic_count

  belongs_to :topic

  def self.make(user: nil, topic: nil)
    find_or_initialize_by(user_id: user.id, topic_id: topic.id).save
  end

  def self.is_favorited(user: nil, topic: nil)
    is_new_topic = topic.created_at > 7.days.ago

    # If is new topic, try cache
    if is_new_topic
      return Rails.cache.fetch(self.cache_key(user.id, topic.id), expires_in: 1.day) do
        find_by user_id: user.id, topic_id: topic
      end
    else
      return find_by user_id: user.id, topic_id: topic
    end
  end

  def self.paginated_topics_for_page(user, page = 1)
    where(user_id: user.id).includes(:topic).order(id: :desc).paginate(page: page, per_page: Node.topics_per_page)
  end

  protected

  def self.cache_key(user_id, topic_id)
    "is_favcorited_for_user_#{user_id}_topic_#{topic_id}"
  end

  def refresh_topic_count
    topic = Topic.find topic_id
    topic.favorites_count = FavoriteTopic::where('topic_id = ?', topic_id).count
    topic.save
  end

  def delete_cache_key
    Rails.cache.delete FavoriteTopic::cache_key(user_id, topic_id)
  end

end
