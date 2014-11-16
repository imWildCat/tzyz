class Topic < ActiveRecord::Base

  belongs_to :author, class_name: 'User'
  belongs_to :node

  has_many :replies, dependent: :destroy

  before_create do
    self.refresher_id = self.author_id
    self.last_replied_at = Time.now
  end

  def self.replies_per_page
    20
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

  def have_page?(page)
    page >= 1 and page <= self.last_page
  end

  def last_page
    self.replies_count / Topic.replies_per_page + 1
  end

  def show(page, valid_click_or_not)
    raise ActionController::RoutingError.new('Not Found') unless have_page?(page)
    clicks_count_up if valid_click_or_not
    self.replies.includes(:author, quoted_reply: [ :author ]).order(created_at:
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