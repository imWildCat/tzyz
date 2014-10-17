class TopicsController < ApplicationController

include RepliesHelper
include TopicsHelper
include ApplicationHelper

  def show
    id = params[:id]
    @page = current_page
    @topic = Topic.find(id)
    last_page = get_page(@topic.replies_count)
    not_found if @page > last_page or @page < 1
    @replies = @topic.replies.paginate(page: @page, per_page: Topic.replies_per_page)
    @topic.clicks_count_up if valid_click?
  end

end