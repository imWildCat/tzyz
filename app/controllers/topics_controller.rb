class TopicsController < ApplicationController

include TopicsHelper
include ApplicationHelper

  def show
    id = params[:id]
    @page = current_page
    @topic = Topic.find(id)
    not_found if @page > @topic.last_page or @page < 1
    @replies = @topic.replies.paginate(page: @page, per_page: Topic.replies_per_page)
    @topic.clicks_count_up if valid_click?
  end

end