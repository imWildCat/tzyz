class FavoriteTopicsController < ApplicationController
  before_action :check_login, only: [:create]

  def create
    topic = Topic::find(params[:topic_id]) || not_found

    fav = FavoriteTopic::make(user: current_user, topic: topic)

    if fav
      flash[:success] = "主题“#{topic.title}”已收藏。"
      redirect_to :back
    else
      flash[:error] = '收藏失败，请重试或者联系管理员'
      redirect_to :back
    end

  end

  def destroy
    fav = FavoriteTopic::find_by user_id: current_user.id, topic_id: params[:topic_id]
    if fav
      fav.destroy
      flash[:info] = '已取消对本主题的收藏。'
      redirect_to :back
    else
      flash[:warning] = '您还没有收藏这个主题呢。'
      redirect_to :back
    end
  end
end
