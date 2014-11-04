class HomeController < ApplicationController
  def index
    @nodes = Rails.cache.fetch('node_list_index', expires_in: 5.minutes) do
      Node.limit(5)
    end
    @tabs = Rails.cache.fetch('tab_list_index', expires_in: 10.minutes) do
      NodeCategory.limit(5)
    end
    @topics = Rails.cache.fetch('topic_list_index', expires_in: 25.seconds) do
      Topic.limit(20).order('last_replied_at desc')
    end
  end

  def about
  end
end
