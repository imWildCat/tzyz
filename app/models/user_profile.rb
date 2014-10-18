class UserProfile < ActiveRecord::Base

  # self.primary_key = 'user_id'

  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
end
