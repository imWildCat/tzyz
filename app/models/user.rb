class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  # Relationships
  # - Message
  has_many :messages, foreign_key: 'receiver_id', dependent: :destroy, class_name: 'Message'
  # has_many :received_messages, through: :messages, source: :receiver
  has_many :sent_messages, foreign_key: 'sender_id', class_name: 'Message'

  #   - Notification
  has_many :notifications, foreign_key: 'receiver_id', dependent: :destroy

  #   - UserProfile
  has_one :user_profile, foreign_key: :owner_id
  #   - UserAvatar
  has_one :user_avatar, foreign_key: :owner_id

  #   - Topic & Reply
  has_many :topics, dependent: :destroy, foreign_key: 'author_id'
  has_many :replies, dependent: :destroy, foreign_key: 'author_id'

  has_many :fortune_alterations

  before_save do
    self.email = email.downcase
  end

  after_create do
    Notification::create_user_welcome(self)
  end


  validates :nickname, presence: true, length: {minimum: 2, maximum: 8}, uniqueness: {case_sensitive: false}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}, if: :password_changed?


  def set_role(role)
    case role
      when :common # Common role
        self.role_id = 1
      when :admin # Administrator
        self.role_id = 9
      else
        self.role_id = 1
    end
  end

  def password_changed?
    !(password.nil? && password_confirmation.nil?)
  end

  def confirmation_url(resource, token)
    'http://test'
  end

  def recent_topics(page, per_page = 10)
    Rails.cache.fetch("user_#{id}_topics_#{updated_at}_n_#{page}_p_#{per_page}", expires_in: 30.minutes) do
      topics.order(updated_at: :desc).includes(:refresher, :node).paginate(page: page,
                                                                   per_page: per_page)
    end
  end

  def recent_replies(page, per_page = 10)
    Rails.cache.fetch("user_#{id}_replies_#{updated_at}_n_#{page}_p_#{per_page}", expires_in: 30.minutes) do
      replies.order(created_at: :desc).includes(:topic => :author).paginate(page: page, per_page: per_page)
    end
  end

  def profile
    if user_profile.nil?
      build_user_profile.save
      user_profile
    else
      user_profile
    end
  end

  # No caching
  # @return [String]
  def avatar
    if user_avatar
      user_avatar
    else
      build_user_avatar.save
      user_avatar
    end
  end


  # Magic properties - which mostly contain data with caching

  def avatar_url
    Rails.cache.fetch(avatar_cache_key, expires_in: 1.days) do
      avatar.url
    end
  end

  def unread_notifications(page = 1)
    @notifications = notifications.order(is_read: :asc, id: :desc).paginate(page: page, per_page: 15)
    # Set them read
    @ids = []
    @notifications.each do |n|
      unless n.is_read
        @ids.append(n.id)
      end
    end
    if @ids.count > 0
      Notification.where(:id => @ids).update_all(is_read: true)
    end

    # Clear cache
    clear_cached_notifications
    @notifications
  end

  def unread_messages(page = 1)
    @messages = messages.order(is_read: :asc, id: :desc).paginate(page: page, per_page: 10)
    # Set them read
    @ids = []
    @messages.each do |m|
      unless m.is_read
        @ids.append(m.id)
      end
    end
    if @ids.count > 0
      Message.where(:id => @ids).update_all(is_read: true)
    end

    # Clear cache
    clear_cached_messages
    @messages
  end

  def unread_notifications_count
    Rails.cache.fetch(unread_notifications_count_cache_key, expires_in: 30.minutes) do
      notifications.where(is_read: false).count
    end
  end

  def unread_messages_count
    Rails.cache.fetch(unread_messages_count_cache_key, expires_in: 30.minutes) do
      messages.where(is_read: false).count
    end
  end

  # Caching clear methods

  def delete_cached_avatar_url
    Rails.cache.delete(avatar_cache_key)
  end

  def clear_cached_notifications
    Rails.cache.delete(unread_notifications_count_cache_key)
  end

  def clear_cached_messages
    Rails.cache.delete(unread_messages_count_cache_key)
  end


  # def send_devise_notification(notification, *args)
  #     AccountMailer.send(notification, self, *args).deliver
  # end

  private

  # Caching keys
  def avatar_cache_key
    "user_#{id}_avatar_url"
  end

  def unread_notifications_count_cache_key
    "user_#{id}_unread_notifications_count"
  end

  def unread_messages_count_cache_key
    "user_#{id}_unread_messages_count"
  end


end
