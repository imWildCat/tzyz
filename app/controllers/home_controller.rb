class HomeController < ApplicationController
  def index
    @node_categories = NodeCategory.cached_cats

    @topics = Rails.cache.fetch('topic_list_index', expires_in: 20.seconds) do
      Topic.limit(20).order('last_replied_at desc')
    end
  end

  def about
  end
end
