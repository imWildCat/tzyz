module AppreciationsHelper
  def topic_appreciated_by_current?(topic)
    if current_user
      topic.is_appreciated_by_user current_user
    else
      false
    end
  end

  def reply_appreciated_by_current?(reply)
    if current_user
      reply.is_appreciated_by_user current_user
    else
      false
    end
  end
end
