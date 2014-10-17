class Topic < ActiveRecord::Base
  belongs_to :user

  has_many :replies, dependent: :destroy

  def author
    self.user
  end


  def clicks_count_up
    self.clicks_count += 1
    self.save
  end
end
