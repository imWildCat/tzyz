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

  def self.count_with_cache
    Rails.cache.fetch('node_count', expires_in: 3.hours) do
      Node.count
    end
  end

  def self.hots
    hot_nodes = Rails.cache.read('hot_nodes')
    if hot_nodes.nil? || hot_nodes.count == 0
      HotNodesWorker.perform_async
      return []
    else
      # TODO: remove flag, which is not necessary
      Rails.cache.fetch('hot_nodes_flag', expires_in: 12.hours) do
        HotNodesWorker.perform_async
      end
    end
    hot_nodes
  end

  def self.news
    Rails.cache.fetch('new_nodes_list', expires_in: 6.hours) do
      Node.includes(:node_category).order(created_at: :desc).limit(5).to_a
    end
  end

  def self.topics_per_page
    20
  end

  def paginated_topics_for_page(page)
    self.topics.order(priority:
                          :desc).paginate(page: page,
                                          per_page: Node.topics_per_page)
  end
end
