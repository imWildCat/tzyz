class RepliesController < ApplicationController

  def create
    topic = Topic.find(params[:topic_id])
    content = params[:reply][:content]

    if current_user
      if content.to_s.blank?
        flash[:error] = '回复内容为空，请输入您的内容。'
        redirect_to :back
        return
      end

      reply = Reply.new(topic_id: topic.id, author_id: current_user.id,
                         content: content)

      if reply.save
        flash[:success] = '回复成功！'
        #update replies_count for current instant of topic
        topic.replies_count += 1
        page = topic.last_page
        redirect_to topic_path(:id => topic.id, :anchor => "reply_#{reply.id}", :page => page)
        return
      else
        flash[:error] = '未知错误。'
        redirect_to :back
      end

    else #didn't sign in
      flash[:error] = '您尚未登陆，请登陆后再发表回复。'
      redirect_to :back
    end
  end
end