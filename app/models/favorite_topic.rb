class FavoriteTopic < ActiveRecord::Base
  after_create :delete_cache_key, :refresh_topic_count
  after_destroy :delete_cache_key, :refresh_topic_count

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
    Rails.cache.delete "is_favcorited_for_user_#{user_id}_topic_#{topic_id}"
    # FIXME：If use the following line, no method error occurs:
    # Rails.cache.delete self.cache_key(user_id, topic_id)
  end

end
