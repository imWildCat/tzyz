class Reply < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  after_save do
    self.topic.replies_count += 1
    self.topic.refresher_id = self.author.id
    self.topic.last_replied_at = Time.now
    self.topic.save
  end

  def author
    self.user
  end
end
