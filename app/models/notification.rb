class Notification < ActiveRecord::Base
  acts_as_paranoid

  TYPE = { replied: 1,
           at_in_reply: 2,
           at_in_topic: 3,
           reply_deleted: 4,
           topic_deleted: 5,
           topic_locked: 6, # Cannot reply the topic
           topic_limited: 7, # Must logged in to read the topic
           user_welcome: 8,
           topic_favorited: 9,
           topic_appreciated: 10,
           reply_appreciated: 11,
           reply_quoted: 12
  }

  enum n_type: TYPE

  before_create :created_at_timestamp
  before_save :clear_target_user_cache

  belongs_to :receiver, class_name: 'User'
  belongs_to :notifiable, polymorphic: true


  # Creation methods
  def self.create_user_welcome(user)
    self.create(receiver: user, n_type: TYPE[:user_welcome])
  end


  def created_at_timestamp
    self.created_at = current_time_from_proper_timezone
  end

  def clear_target_user_cache
    receiver.clear_cached_notifications
    # Notice: mush return true!
    true
  end

end
