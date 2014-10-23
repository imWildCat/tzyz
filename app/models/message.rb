class Message < ActiveRecord::Base
  # Soft delete: https://github.com/radar/paranoia
  acts_as_paranoid

  before_create :created_at_timestamp
  before_save :clear_receiver_cache
  validate :receiver_and_sender_not_same

  belongs_to :receiver, class_name: 'User'
  belongs_to :sender, class_name: 'User'

  protected
  def created_at_timestamp
    self.created_at = current_time_from_proper_timezone
  end

  def clear_receiver_cache
    receiver.clear_cached_messages
  end

  def receiver_and_sender_not_same
    if receiver_id == sender_id
      errors.add(:receiver_id, '消息发送者和接收者不能相同')
    end
  end

end
