class Reply < ActiveRecord::Base

  # Relationships

  belongs_to :topic
  belongs_to :author, class_name: 'User', touch: true
  has_many :appreciations, as: :appreciative
  has_many :fortune_alterations, as: :fortune_alterable
  # - Reply to
  belongs_to :quoted_reply, class_name: 'Reply'

  after_create :topic_replies_count_plus, :perform_new_reply_fortune_alterations

  def is_appreciated_by_user(user)
    Rails.cache.fetch(Appreciation.build_cache_key(user_id: user.id, reply_id: self.id), expires_in: 7.days) do
      appreciations.where(user_id: user.id).count > 0
    end
  end

  protected
  def topic_replies_count_plus
    self.topic.replies_count += 1
    self.topic.refresher_id = self.author_id
    self.topic.save
  end

  def perform_new_reply_fortune_alterations
    # Cost
    fortune_alterations.new(user_id: author_id, reason: :new_reply).save
    # For author of topic(if it is not the author of reply)
    topic.fortune_alterations.new(user_id: topic.author_id, reason: :topic_replied).save unless topic.author_id ==
        author_id
  end



end