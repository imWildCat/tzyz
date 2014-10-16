class RepliesController < ApplicationController
include RepliesHelper

  def create
    @topic = Topic.find(params[:topic_id])
    content = params[:reply][:content]

    if current_user
      user = current_user

      if content.to_s.blank?
        flash[:error] = '回复内容为空，请输入您的内容。'
        redirect_to :back
        return
      end

      @reply = Reply.new(topic_id: @topic.id, user_id: user.id,
                         content: content)

      if @reply.save
        flash[:success] = '回复成功！'
        position = @topic.reply_count + 1
        page = get_page position
        redirect_to topic_path(:id => @topic.id, :anchor => "position-#{position}", :page => page)
        return
      end

    else #didn't sign in
      flash[:error] = '您尚未登陆，请登陆后再发表回复。'
      redirect_to :back
    end
  end
end
