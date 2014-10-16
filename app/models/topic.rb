class Topic < ActiveRecord::Base
  belongs_to :user

  has_many :replies, dependent: :destroy

  def author
    self.user
  end


  def click_count_up
    self.click_count += 1
    self.save
  end
end
