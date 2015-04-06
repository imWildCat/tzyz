class Appreciation < ActiveRecord::Base
  after_create :perform_appreciation_fortune_alterations, :perform_new_appreciation_notification
  after_save :delete_cache_key, :refresh_count
  after_destroy :delete_cache_key, :refresh_count

  belongs_to :user
  belongs_to :appreciative, polymorphic: true
  has_many :fortune_alterations, as: :fortune_alterable
  has_many :notifications, as: :notifiable

  def self.make(user)
    appreciation = self.new(user_id: user.id)
    return false if appreciation.appreciative.is_appreciated_by_user user
    return false if appreciation.appreciative.author_id == user.id
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
      topic.appreciation_count = topic.appreciations.count
      topic.save
    elsif appreciative_type == 'Reply' # Reply
      reply = Reply.find appreciative_id
      reply.appreciation_count = reply.appreciations.count
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

  def perform_appreciation_fortune_alterations
    if appreciative_type == 'Topic'
      fortune_alterations.new(user_id: appreciative.author_id, reason: :topic_appreciated).save
      fortune_alterations.new(user_id: user_id, reason: :send_topic_appreciation).save
    elsif appreciative_type == 'Reply'
      fortune_alterations.new(user_id: appreciative.author_id, reason: :reply_appreciated).save
      fortune_alterations.new(user_id: user_id, reason: :send_reply_appreciation).save
    end
  end

  def perform_new_appreciation_notification
    if self.user_id != self.appreciative.author_id
      case self.appreciative_type
        when 'Topic'
          self.notifications.create(receiver_id: self.appreciative.author_id,
                                    n_type: :topic_appreciated)
        when 'Reply'
          self.notifications.create(receiver_id: self.appreciative.author_id,
                                    n_type: :reply_appreciated)
      end
    end
  end
end