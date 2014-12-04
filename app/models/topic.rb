class Topic < ActiveRecord::Base
  belongs_to :node
  belongs_to :author, class_name: 'User'
  belongs_to :refresher, class_name: 'User'
  has_many :replies, dependent: :destroy
  has_many :appreciations, as: :appreciative
  has_many :fortune_alterations, as: :fortune_alterable
  has_many :notifications, as: :notifiable

  before_create do
    self.refresher_id = self.author_id
  end

  after_create :perform_new_topic_fortune_alteration

  def self.replies_per_page
    20
  end

  def is_appreciated_by_user(user)
    Rails.cache.fetch(Appreciation.build_cache_key(user_id: user.id, topic_id: self.id), expires_in: 7.days) do
      appreciations.where(user_id: user.id).count > 0
    end
  end

  def clicks_count_up
    self.clicks_count += 1
    self.save
  end

  # Caution
  # Returns nil if refresher not found.
  def refresher
    User.find_by_id(self.refresher_id)
  end

  def perform_new_topic_fortune_alteration
    fortune_alterations.new(user: author, reason: :new_topic).save
  end

  def have_page?(page)
    page >= 1 and page <= self.last_page
  end

  def last_page
    (self.replies_count - 1) / Topic.replies_per_page + 1
  end

  def show(page, valid_click_or_not)
    raise ActionController::RoutingError.new('Not Found') unless have_page?(page)
    clicks_count_up if valid_click_or_not
    self.replies.includes(:author, quoted_reply: [:author]).order(created_at:
                                                                      :asc).paginate(page: page,
                                                                                     per_page: Topic.replies_per_page)
  end

  def valid_click_by_user?(user_id)
    key = 'clicked_t_' + self.id.to_s
    if user_id
      return false if self.author.id == user_id
      return false unless session[key].nil?
    end
    session[key] = true
    true
    #need to add more
  end
end