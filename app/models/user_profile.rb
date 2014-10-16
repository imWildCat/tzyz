class UserProfile < ActiveRecord::Base
  # self.primary_key = 'user_id'
  belongs_to :user, foreign_key: :id
end
