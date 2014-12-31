class HomeController < ApplicationController
  def index
    @node_categories = NodeCategory.cached_cats

    @topics = Rails.cache.fetch('topic_list_index') do
      Topic.limit(20).order('updated_at desc')
    end
  end

  def about

  end


end
