class NodeCategory < ActiveRecord::Base

  has_many :nodes
  has_many :management_logs, as: :manageable

  validates :name, uniqueness: {case_sensitive: false}, presence: true
  validates :slug, uniqueness: {case_sensitive: false}, presence: true

  def to_s
    "节点分类：#{name}"
  end

  def self.cached_cats
    Rails.cache.fetch('node_categories', expires_in: 6.hours) do
      NodeCategory.limit(11)
    end
  end

  def topics(per_page: 20, page: 1)
    Topic.where(:node => nodes).order(updated_at: :desc).paginate(page: page, per_page: per_page)
  end

  def self.fetch_list
    Rails.cache.fetch('node_category_list', expires_in: 1.hour) do
      includes(:nodes).all
    end
  end

  # No use
  # def node_ids(cache: 6.hours)
  #   Rails.cache.fetch("node_category_#{id}_ids", expries_in: cache) do
  #     @ids = []
  #     @nodes = nodes.select(:id).all
  #     @nodes.each do |n|
  #       @ids.append n.id
  #     end
  #     return @ids
  #   end
  # end

end
