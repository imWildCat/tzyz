class Cpanel::TopicsController < Cpanel::ApplicationController
  include ApplicationHelper

  def show
    @topics = Topic.order(priority: :asc).includes(:author, :refresher, :node).paginate(page: current_page, per_page: 15)
  end

  def edit
    @topic = Topic.find params[:id]
  end

  def update
    topic_new_data = params.require(:topic).permit(:title, :content, :status)
    topic = Topic.find params[:id]

    topic.assign_attributes_with_log topic_new_data, current_user

    if topic.save
      flash[:success] = '话题修改成功。'
    else
      flash[:error] = '话题修改失败。'
    end

    redirect_to edit_cpanel_topic_path(topic)
  end

end
