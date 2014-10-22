class TopicsController < ApplicationController

include TopicsHelper
include ApplicationHelper

  def show
    id = params[:id]
    page = current_page
    @topic = Topic.find(id)
    not_found if page > @topic.last_page or page < 1
    @replies = @topic.replies.paginate(page: page, per_page: Topic.replies_per_page)
    @topic.clicks_count_up if valid_click?
  end

  def new
    @node = Node.find_by_slug(params[:slug]) or not_found
  end

  def create
    t = params[:topic]
    if current_user

      if t[:title].blank? or t[:content].blank?
        flash[:error] = '标题或主题内容不能为空。'
        return redirect_to :back
      end

      node = Node.find_by_slug(topic[:node_slug]) or not_found
      topic = node.topics.new(title: t[:title], author_id: current_user.id, content: t[:content])

      if topic.save
        flash[:success] = '主题发表成功。'
        return redirect_to topic_path(topic)
      else
        flash[:error] = '未知错误。'
        return redirect_to :back
      end

    else #didn't sign in
      flash[:error] = '您尚未登陆，请登陆后再发表回复。'
      redirect_to :back
    end
  end

end