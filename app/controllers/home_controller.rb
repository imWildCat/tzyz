class HomeController < ApplicationController
  def index
    @node_categories = NodeCategory.cached_cats

    @topics = Rails.cache.fetch('topic_list_index', expires_in: 20.seconds) do
      Topic.limit(20).order('priority desc')
    end
  end

  def about

  end

  def api
    add_breadcrumb 'API 参考'
  end

end
