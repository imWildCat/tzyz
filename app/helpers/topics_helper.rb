module TopicsHelper
  def valid_click_for_topic?(id)
    key = 'clicked_t_' + id.to_s
    if current_user
      return false if @topic.author.id == current_user.id
      return false unless session[key].nil?
    end
    session[key] = true
    true
    #need to add more
  end

  def illegal_node
    flash[:warning] = '请为主题选择一个节点。'
    redirect_to new_topic_path
  end
end