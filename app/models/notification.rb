class Notification < ActiveRecord::Base
  acts_as_paranoid

  before_create :created_at_timestamp
  before_save :clear_target_user_cache

  belongs_to :receiver, class_name: 'User'

  # Creation methods
  def self.create_user_welcome(user)
    self.create(receiver: user, n_type: generate_type(:user_welcome))
  end

  protected
  def created_at_timestamp
    self.created_at = current_time_from_proper_timezone
  end

  def clear_target_user_cache
    receiver.clear_cached_notifications
  end

  def self.generate_type(type)
    case type
      # Common User Actions
      when :reply then
        1
      when :at_in_reply then
        2
      when :at_in_topic then
        3
      # Admin Actions
      when :reply_deleted then
        4
      when :topic_deleted then
        5
      when :topic_locked then  # Cannot reply the topic
        6
      when :topic_limited then # Must logged in to read the topic
        7
      when :user_welcome then
        9
      else
        0
    end
  end

end
