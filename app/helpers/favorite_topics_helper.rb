module FavoriteTopicsHelper
  def topic_favorited_by_current?(topic)
    if current_user
      FavoriteTopic::is_favorited user: current_user, topic: topic
    else
      false
    end
  end
end
