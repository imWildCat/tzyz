class RepliesController < ApplicationController
  include ApplicationHelper

  before_action :check_login

  def create
    topic = Topic.find(params[:topic_id])
    content = sanitizer(params[:content])
    quoted_reply_id = params[:quoted_reply_id].to_i

    if content.to_s.blank?
      flash[:error] = '回复内容为空，请输入您的内容。'
      redirect_to :back
      return
    end

    reply = Reply.new(topic_id: topic.id, author_id: current_user.id,
                      content: content)
    reply.position = topic.replies_count + 1

    # handle priority
    # TODO: find a more friendly way to sort the topics
    if topic.created_at > 1.days.ago
      topic.priority = Time.now
    elsif topic.created_at > 3.days.ago
      delta = (Time.now - topic.created_at) * 0.0009
      # delta = 180 if delta > 180
      topic.priority = Time.now - delta
    elsif topic.created_at > 7.days.ago
      delta = (Time.now - topic.created_at) * 0.0015
      delta = 3600 if delta > 3600
      topic.priority = Time.now - delta
    end
    topic.save

    # Handle quoted reply
    if quoted_reply_id > 0
      quoted_reply = Reply.find(quoted_reply_id)
      reply.quoted_reply = quoted_reply if quoted_reply.topic_id == topic.id
    end

    if reply.save
      flash[:success] = '回复成功！'
      # If new reply has a quoted_reply, and the authors of them are NOT the same, send notification
      if reply.quoted_reply and (reply.author_id != reply.quoted_reply.author_id)
        reply.notifications.create receiver: reply.quoted_reply.author, n_type: :reply_quoted
      end
      redirect_to topic_path(id: topic.id, anchor: reply.reply_anchor, page: reply.reply_page)
    else
      flash[:error] = '未知错误。'
      redirect_to :back
    end
  end

  def appreciate
    reply = Reply::find(params[:reply_id]) || not_found
    if reply.appreciations.make current_user
      flash[:success] = '已经发送对本回复的感谢。'
      redirect_to :back
    else
      flash[:error] = '操作失败，您不能对自己的回复发送感谢。'
      redirect_to :back
    end
  end

end