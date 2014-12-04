class ManagementHistory < ActiveRecord::Base

  enum action_type: [:creating, :updating, :destroying]

  belongs_to :user
  belongs_to :manageable, polymorphic: true

end
