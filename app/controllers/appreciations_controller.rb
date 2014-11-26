class AppreciationsController < ApplicationController
  before_action :check_login, only: [:create]

  def create
    topic = Topic::find(params[:topic_id]) || not_found

    appreciation = Appreciation::make(user: current_user, topic: topic)

    if appreciation
      flash[:success] = '已经发送对本主题的感谢。'
      redirect_to :back
    else
      flash[:error] = '操作失败，请重试或者联系管理员'
      redirect_to :back
    end
  end

end
