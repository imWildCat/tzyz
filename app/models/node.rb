class Node < ActiveRecord::Base

  attr_reader :topics_per_page

  belongs_to :node_category

  has_many :topics

  def self.topics_per_page
    20
  end

  def paginated_topics_for_page(page)
    self.topics.order(updated_at:
                          :desc).paginate(page: page,
                                          per_page: Node.topics_per_page)
  end
end
