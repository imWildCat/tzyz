class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  USER_GROUP = {
      normal: 1,
      moderator: 6, # Node manager
      administrator: 9
  }

  USER_ROLE = {
      newbie: 1
  }

  enum group: USER_GROUP
  enum role: USER_ROLE

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

  has_many :management_logs, as: :manageable

  before_save do
    self.email = email.downcase
  end

  after_create :send_welcome_notification, :perform_new_user_fortune_alteration


  validates :nickname, presence: true, length: {minimum: 2, maximum: 8}, uniqueness: {case_sensitive: false}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}, if: :password_changed?
  validates :group, presence: true
  validates :role, presence: true

  def to_s
    "用户：#{display_name}"
  end

  def self.group_name_for(group_key)
    case group_key
      when 'normal'
        return '普通'
      when 'moderator'
        return 'Warden'
      when 'administrator'
        return 'Titan'
      else
        return '未知'
    end
  end

  def group_name
    User::group_name_for(group)
  end

  def role_name
    case role
      when 'newbie'
        return '新人'
      else
        return '未知'
    end
  end

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

  def recent_topics(page, per_page = 10) # With Caching
    Rails.cache.fetch("user_#{id}_topics_#{updated_at}_n_#{page}_p_#{per_page}", expires_in: 30.minutes) do
      topics.order(updated_at: :desc).includes(:refresher, :node).paginate(page: page,
                                                                            per_page: per_page).to_a
    end
  end

  def recent_replies(page, per_page = 10) # With Caching
    Rails.cache.fetch("user_#{id}_replies_#{updated_at}_n_#{page}_p_#{per_page}", expires_in: 30.minutes) do
      replies.order(created_at: :desc).includes(:topic => :author).paginate(page: page, per_page: per_page)
    end
  end

  def recent_fortune_alterations(page, per_page = 20) # No caching
    fortune_alterations.order(id: :desc).paginate(page: page, per_page: per_page)
  end

  def display_name
    nickname
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

  protected
  def send_welcome_notification
    Notification::create_user_welcome(self)
  end

  def perform_new_user_fortune_alteration
    FortuneAlteration.new(reason: :new_user, user: self).save
  end

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
