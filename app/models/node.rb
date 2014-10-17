class Node < ActiveRecord::Base

  belongs_to :node_category

  has_many :topics

  def self.topics_per_page
    20
  end
end
