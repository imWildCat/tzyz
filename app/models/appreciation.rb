class Appreciation < ActiveRecord::Base
  after_save :delete_cache_key, :refresh_count
  after_destroy :delete_cache_key, :refresh_count

  belongs_to :appreciative, polymorphic: true

  def self.make(user)
    appreciation = self.new(user_id: user.id)
    appreciation.save
  end

  protected

  def self.build_cache_key(user_id: nil, topic_id: nil, reply_id: nil?)
    return nil if user_id.nil?
    return "is_appreciated_topic[#{topic_id}]_u[#{user_id}]" unless topic_id.nil?
    return "is_appreciated_reply[#{reply_id}]_u[#{user_id}]" unless reply_id.nil?
    nil
  end

  def refresh_count
    if appreciative_type == 'Topic' # Topic
      topic = Topic.find appreciative_id
      topic.appreciations_count = topic.appreciations.count
      topic.save
    elsif appreciative_type == 'Reply' # Reply
      reply = Reply.find appreciative_id
      reply.appreciations_count = reply.appreciations.count
      reply.save
    end
  end

  def delete_cache_key
    if appreciative_type == 'Topic' # Topic
      Rails.cache.delete Appreciation::build_cache_key(user_id: user_id, topic_id: appreciative_id)
    elsif appreciative_type == 'Reply' # Reply
      Rails.cache.delete Appreciation::build_cache_key(user_id: user_id, reply_id: appreciative_id)
    end
  end
end