module AppreciationsHelper
  def is_topic_appreciated_by_current(topic)
    if current_user
      Appreciation::is_appreciated user: current_user, topic: topic
    else
      false
    end
  end

  def is_reply_appreciated_by_current(reply)
    if current_user
      Appreciation::is_appreciated user: current_user, reply: reply
    else
      false
    end
  end
end
