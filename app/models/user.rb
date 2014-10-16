class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  before_save {
    self.email = email.downcase
  }

  validates :nickname, presence: true, length: {minimum: 2, maximum: 8}, uniqueness: {case_sensitive: false}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}

  has_many :topics, dependent: :destroy
  has_many :replies, dependent: :destroy

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

  def avatar_url
    '/assets/no_avatar.png'
  end

  # def send_devise_notification(notification, *args)
  #     AccountMailer.send(notification, self, *args).deliver
  # end

  private


end
