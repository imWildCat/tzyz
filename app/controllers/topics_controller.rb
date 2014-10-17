class TopicsController < ApplicationController

include RepliesHelper
include TopicsHelper
  def show
    id = params[:id]
    page = params[:page]
    @topic = Topic.find(id)
    @page = page.nil? ? 1 : page.to_i
    last_page = get_page(@topic.replies_count)
    not_found if @page > last_page or @page < 1
    @replies = @topic.replies.paginate(page: @page, per_page: 20)
    @topic.clicks_count_up if valid_click?
  end

end