class TopicsController < ApplicationController

  include TopicsHelper
  include ApplicationHelper

  before_action :check_login, only: [:new, :create]

  def show
    id = params[:id]
    page = current_page
    @topic = Topic.includes(:node).find(id)
    @replies = @topic.show(page, valid_click_for_topic?(@topic.id))

    add_breadcrumb @topic.node.name, node_path(@topic.node.slug)
    add_breadcrumb '阅读话题'
  end

  def new
    if node = Node.find_by_slug(params[:slug])
      @topic = node.topics.new
    else params[:slug].nil?
      @topic = Topic.new
    end

    add_breadcrumb '创建新话题'
  end

  def create
    t = params[:topic]

    if t[:title].blank?
      flash[:error] = '标题不能为空。'
      return redirect_to :back
    end
    node = Node.find_by_id(t[:node_id]) or return illegal_node
    topic = node.topics.new(title: t[:title], author_id: current_user.id, content: sanitizer(params[:content]))

    if topic.save
      flash[:success] = '主题发表成功。'
      redirect_to topic_path(topic)
    else
      flash[:error] = '未知错误。'
      redirect_to :back
    end
  end

  def appreciate
    topic = Topic::find(params[:topic_id]) || not_found

    if topic.appreciations.make(current_user)
      flash[:success] = '已经发送对本主题的感谢。'
      redirect_to :back
    else
      flash[:error] = '操作失败，您不能对自己的主题发送感谢。'
      redirect_to :back
    end
  end
end