class Reply < ActiveRecord::Base
  belongs_to :topic
  belongs_to :author, class_name: 'User'

  after_save do
    self.topic.replies_count += 1
    self.topic.refresher_id = self.author_id
    self.topic.last_replied_at = Time.now
    self.topic.save
  end

  # Relationships
  # - Reply to
  belongs_to :quoted_reply, class_name: 'Reply'

end