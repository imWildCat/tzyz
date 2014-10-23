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

  def show(page, valid_click)
    raise ActionController::RoutingError.new('Not Found') unless have_page?(page)
    clicks_count_up if valid_click
    self.replies.order(created_at:
                           :desc).paginate(page: page,
                                           per_page: Topic.replies_per_page)
  end
end