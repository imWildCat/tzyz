class NodeController < ApplicationController

  include ApplicationHelper

  def show
    @node = Node.find_by_slug(params[:slug]) or not_found
    @page = current_page
    @topics = @node.topics.paginate(page: @page, per_page: Node.topics_per_page)

  end
end
