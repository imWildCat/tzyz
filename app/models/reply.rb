class Reply < ActiveRecord::Base

  belongs_to :topic
  belongs_to :author, class_name: 'User', touch: true
  has_many :appreciations, as: :appreciative
  # appreciative_type of Reply is 1, the following line is not working correctly:
  # has_many :appreciations, as: :appreciative

  after_save do
    self.topic.replies_count += 1
    self.topic.refresher_id = self.author_id
    self.topic.save
  end

  def is_appreciated_by_user(user)
    Rails.cache.fetch(Appreciation.build_cache_key(user_id: user.id, reply_id: self.id), expires_in: 7.days) do
      appreciations.where(user_id: user.id).count > 0
    end
  end

  # Relationships
  # - Reply to
  belongs_to :quoted_reply, class_name: 'Reply'

end