class FavoriteTopicsController < ApplicationController
  include ApplicationHelper

  before_action :check_login

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

  def show
    @favorites = FavoriteTopic::paginated_topics_for_page(current_user, current_page)
    @topics = []
    @favorites.each do |f|
      @topics.append(f.topic)
    end

    add_breadcrumb '个人中心'
    add_breadcrumb '我的收藏'
  end

end
