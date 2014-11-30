module FortuneAlterationsHelper

  def fortune_to_coins(fortune)
    fortune = fortune.to_i
    gold = fortune % 1000000 / 10000
    silver = fortune % 10000 / 100
    copper = fortune % 100

    output = '<span class="fortune">'
    output += "<span class=\"gold\">#{gold}#{image_tag 'coins/gold_coin@2x.png'}</span>" if gold > 0
    output += "<span class=\"silver\">#{silver}#{image_tag 'coins/silver_coin@2x.png'}</span>" if silver > 0
    output += "<span class=\"copper\">#{copper}#{image_tag 'coins/copper_coin@2x.png'}</span>"
    output += '</span>'
    return output.html_safe
  end

  def fortune_alteration_reason_to_s(fortune_alteration)
    case fortune_alteration.reason
      when 'new_topic'
        return '创建主题'
      when 'new_reply'
        return '创建回复'
      when 'edit_topic'
        return '编辑主题'
      when 'edit_reply'
        return '编辑回复'
      when 'quote_reply'
        return '引用回复'
      when 'mention_user'
        return '提到用户'
      when 'send_message'
        return '发送私信'
      when 'topic_replied'
        return '主题回复收益'
      when 'topic_appreciated'
        return '主题感谢收益'
      when 'send_topic_appreciation'
        return '发送对主题的感谢'
      when 'reply_appreciated'
        return '回复感谢收益'
      when 'send_reply_appreciation'
        return '发送对回复的感谢'
      when 'daily_login'
        return '每日登录收益'
      when 'new_user'
        return '新注册用户奖励'
      else
        return '未知'
    end
  end

  def fortune_alteration_to_des(fortune_alteration)
    case fortune_alteration.reason
      when 'new_topic'
        related_topic = fortune_alteration.fortune_alterable
        output = "创建新主题 › #{link_to related_topic.title, related_topic}"
      when 'new_reply'
        related_topic = fortune_alteration.fortune_alterable.topic
        output = "创建回复 › #{link_to related_topic.title, related_topic}"
      when 'edit_topic'
        related_topic = fortune_alteration.fortune_alterable
        output = "编辑主题 › #{link_to related_topic.title, related_topic}"
      when 'edit_reply'
        related_topic = fortune_alteration.fortune_alterable.topic
        output = "编辑回复 › #{link_to related_topic.title, related_topic}"
      when 'quote_reply'
        related_topic = fortune_alteration.fortune_alterable.topic
        output = "引用回复 › #{link_to related_topic.title, related_topic}"
      when 'mention_user'
        output = '提到用户'
      when 'send_message'
        output = '发送私信'
      when 'topic_replied'
        related_reply = fortune_alteration.fortune_alterable
        related_topic = related_reply.topic
        output = "收到 #{link_to related_reply.author.display_name, related_reply.author} 的回复 › #{link_to related_topic.title, related_topic}"
      when 'topic_appreciated'
        related_topic = fortune_alteration.fortune_alterable.appreciative
        related_user = fortune_alteration.fortune_alterable.user
        output = "#{link_to related_user.display_name, related_user} 对你的主题致谢 › #{link_to related_topic.title,
                                                                                         related_topic}"
      when 'send_topic_appreciation'
        related_topic = fortune_alteration.fortune_alterable.appreciative
        related_user = related_topic.author
        output = " 对 #{link_to related_user.display_name, related_user} 的主题致谢 › #{link_to related_topic.title,
                                                                                          related_topic} "
      when 'reply_appreciated'
        related_reply = fortune_alteration.fortune_alterable.appreciative
        related_topic = related_reply.topic
        related_user = fortune_alteration.fortune_alterable.user
        output = "#{link_to related_user.display_name, related_user} 对你的回复（##{related_reply.position}）致谢 › #{
        link_to related_topic.title, related_topic}"
      when 'send_reply_appreciation'
        related_reply = fortune_alteration.fortune_alterable.appreciative
        related_topic = related_reply.topic
        related_user = fortune_alteration.fortune_alterable.appreciative.author
        output = " 对 #{link_to related_user.display_name, related_user} 的回复（##{related_reply.position}）致谢 › #{
        link_to related_topic.title, related_topic} "
      when 'daily_login'
        output = '每日登录收益'
      when 'new_user'
        output = '启动资金'
      else
        output = '未知，请咨询站务组'
    end
    output.html_safe
  end
end
