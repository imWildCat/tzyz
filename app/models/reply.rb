class Reply < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  after_save do
    self.topic.reply_count += 1
    #self.topic.updated_at= self.created_at
    self.topic.save
  end

  def author
    self.user
  end
end
