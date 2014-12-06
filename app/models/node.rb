class Node < ActiveRecord::Base

  attr_reader :topics_per_page

  belongs_to :node_category

  has_many :topics
  has_many :management_logs, as: :manageable

  validates :node_category_id, presence: true
  validates :name, uniqueness: {case_sensitive: false}, presence: true
  validates :slug, uniqueness: {case_sensitive: false}, presence: true

  def to_s
    "节点：#{name}"
  end

  def self.topics_per_page
    20
  end

  def paginated_topics_for_page(page)
    self.topics.order(updated_at:
                          :desc).paginate(page: page,
                                          per_page: Node.topics_per_page)
  end
end
