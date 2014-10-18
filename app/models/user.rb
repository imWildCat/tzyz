class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  # Relationships
  #   - Message
  has_many :messages, foreign_key: 'receiver_id', dependent: :destroy, class_name: 'Message'
  # has_many :received_messages, through: :messages, source: :receiver
  has_many :sent_messages, foreign_key: 'sender_id', class_name: 'Message'

  #   - UserProfile
  has_one :user_profile, foreign_key: :owner_id
  #   - UserAvatar
  has_one :user_avatar, foreign_key: :owner_id

  #   - Topic & Reply
  has_many :topics, dependent: :destroy, foreign_key: 'author_id'
  has_many :replies, dependent: :destroy



  before_save do
    self.email = email.downcase
  end


  validates :nickname, presence: true, length: {minimum: 2, maximum: 8}, uniqueness: {case_sensitive: false}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}



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

  def confirmation_url(resource, token)
    'http://test'
  end

  def profile
    # TODO: Implement cache
    if user_profile.nil?
      build_user_profile.save
      user_profile
    else
      user_profile
    end
  end

  def avatar
    # TODO: Implement cache
    if user_avatar
      user_avatar
    else
      build_user_avatar.save
      user_avatar
    end
  end

  def avatar_url
    '/assets/no_avatar.png'
  end

  # def send_devise_notification(notification, *args)
  #     AccountMailer.send(notification, self, *args).deliver
  # end

  private


end
