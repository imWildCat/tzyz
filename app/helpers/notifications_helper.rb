module NotificationsHelper

  def notification_image(notification)
    case notification.n_type
      when 'replied', 'mentioned_in_reply'
        reply = notification.notifiable
        image_tag reply.author.avatar.url
      when 'mentioned_in_topic'
        topic = notification.notifiable
        image_tag topic.author.avatar_url
      else
        image_tag UserAvatar.no_user_avatar_url
    end
  end

  def notification_title(notification)
    case notification.n_type
      when 'replied'
        reply = notification.notifiable
        output = "#{link_to(reply.author.nickname, reply.author)} 回复了你的主题：
                  #{link_to(reply.topic.title, topic_path(reply.topic, anchor: reply.reply_anchor, page: reply.reply_page))}"
      when 'mentioned_in_reply'
        reply = notification.notifiable
        output = "#{link_to(reply.author.nickname, reply.author)} 在
                  #{link_to(reply.topic.title, topic_path(reply.topic, anchor: reply.reply_anchor, page: reply.reply_page))}
                  主题的回复中提到了你"
      when 'mentioned_in_topic'
        topic = notification.notifiable
        output = "#{link_to(topic.author.nickname, topic.author)} 在主题 #{link_to(topic.title, topic)} 中提到了你"
      when 'reply_deleted'
        reply = notification.notifiable
        output = "你在主题 #{link_to(reply.topic.title, reply.topic)} 中的回复已被管理员删除"
      when 'topic_deleted'
        topic = notification.notifiable
        output = "你的主题 #{link_to(topic.title, topic)} 已被管理员删除"
      when 'topic_locked'
        topic = notification.notifiable
        output = "你的主题 #{link_to(topic.title, topic)} 已被管理员锁定"
      when 'user_welcome'
        output = "#{current_user.nickname}，感谢您注册 滕州一中校友会"
      when 'topic_favorited'
        favorite = FavoriteTopic.with_deleted.find notification.notifiable_id
        output = "#{favorite.user.display_name} 收藏了你的主题 #{link_to(favorite.topic.title, favorite.topic)}"
      when 'topic_appreciated'
        appreciation = notification.notifiable
        topic = appreciation.appreciative
        output = "#{link_to appreciation.user.display_name, appreciation.user} 感谢了您的主题 #{link_to(topic.title, topic)}"
      when 'reply_appreciated'
        appreciation = notification.notifiable
        reply = appreciation.appreciative
        output = "#{link_to appreciation.user.display_name, appreciation.user} 感谢了您在主题 #{link_to(reply.topic.title, topic_path(reply.topic, anchor: reply.reply_anchor, page: reply.reply_page))} 中的回复"
      when 'reply_quoted'
        reply = notification.notifiable
        output = "#{link_to(reply.author.nickname, reply.author)} 在主题
                  #{link_to(reply.topic.title, topic_path(reply.topic, anchor: reply.reply_anchor, page: reply.reply_page))}
                  中回复了你的发言"
      else
        output = "未知通知, Notification type: #{notification.n_type.to_s}, 请联系管理员，谢谢。"
    end
    output.html_safe
  end

  def notification_content(notification)
    case notification.n_type
      when 'replied',
          'mentioned_in_reply',
          'reply_deleted',
          'mentioned_in_topic',
          'topic_locked',
          'reply_quoted'
        output = strip_and_cut notification.notifiable.content
      when 'topic_deleted',
          'reply_deleted'
        output = deleted_content strip_and_cut(notification.notifiable.content)
      when 'topic_appreciated', 'reply_appreciated'
        output = strip_and_cut notification.notifiable.appreciative.content
      # when Notification::TYPE[:topic_limited]
      when 'user_welcome'
        output = '请遵守社区规范，希望您享受在这个社区的美好时光 : )'
      else
        output = ''
    end
    output.html_safe
  end

  def generate_mention_user_notifications_for(notifiable)
    at_user_strings = notifiable.content.scan(/@[\u4e00-\u9fa5\w]{1,20}\[\d{1,10}\]/)
    at_user_strings.each do |s|
      mentioned_user_id = /\[(\d{1,10})(\])/.match(s)[1]
      next if mentioned_user_id.to_i == notifiable.author_id
      if User.where(id: mentioned_user_id).count > 0
        if notifiable.class.name == 'Reply'
          notifiable.notifications.create receiver_id: mentioned_user_id, n_type: :mentioned_in_reply
        end
        if notifiable.class.name == 'Topic'
          notifiable.notifications.create receiver_id: mentioned_user_id, n_type: :mentioned_in_topic
        end
      end
    end
  end

  protected

  SHORT_CONTENT_LENGTH = 140

  def strip_and_cut(content)
    striped_content = strip_tags content
    if striped_content.length <= SHORT_CONTENT_LENGTH
      striped_content
    else
      striped_content[0..SHORT_CONTENT_LENGTH-1] + ' ...'
    end
  end

  def deleted_content(content)
    "<s>#{content}</s>"
  end
end