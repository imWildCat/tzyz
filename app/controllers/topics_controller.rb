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
    return if not_login('您尚未登录，请登录后再发表主题。')
    @node = Node.find_by_slug(params[:slug]) or not_found
    render('new')
  end

  def create
    return if not_login('您尚未登陆，请登陆后再发表回复。')
    t = params[:topic]

    if t[:title].blank?
      flash[:error] = '标题不能为空。'
      return redirect_to :back
    end

    node = Node.find_by_slug(t[:node_slug]) or not_found
    topic = node.topics.new(title: t[:title], author_id: current_user.id, content: t[:content])

    if topic.save
      flash[:success] = '主题发表成功。'
      redirect_to topic_path(topic)
    else
      flash[:error] = '未知错误。'
      redirect_to :back
    end
  end
end