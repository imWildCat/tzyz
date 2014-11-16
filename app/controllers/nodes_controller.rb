class NodesController < ApplicationController
  include ApplicationHelper

  def show
    @node = Node.find_by_slug(params[:slug]) or not_found
    @page = current_page
    @topics = @node.paginated_topics_for_page(@page)

    add_breadcrumb @node.name
  end

  def all
    add_breadcrumb '节点列表'
    @node_categories = Rails.cache.fetch('all_categories', expires_in: 1.day) do
      NodeCategory::includes(:nodes).all
    end
  end

end
