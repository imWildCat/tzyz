class NodesController < ApplicationController
  include ApplicationHelper

  def show
    @node = Node.find_by_slug(params[:slug]) or not_found
    @page = current_page
    @topics = @node.paginated_topics_for_page(@page)

    add_breadcrumb @node.name
  end

end
