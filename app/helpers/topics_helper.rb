module TopicsHelper

  def get_first_position_in(page)
    (page - 1) * 20 + 1
  end

  def valid_click?
    if current_user
      false if @topic.author.id == current_user.id
    end
    #need to add more
  end
end