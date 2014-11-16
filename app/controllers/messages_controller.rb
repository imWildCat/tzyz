class MessagesController < ApplicationController
  before_action :check_login

  def show
    add_breadcrumb '个人中心'
    add_breadcrumb '消息'
    @messages = current_user.unread_messages
  end

  def create
    @params = params.require(:message).permit(:content, :receiver_id, :receiver_name)
    if !@params[:receiver_id].nil?
      @receiver = User.find(@params[:receiver_id]) || not_found
    elsif !@params[:receiver_name].nil?
      @receiver = User.find_by_nickname(@params[:receiver_name])
    else
      flash[:error] = '用户不存在。'
      redirect_to request.referer
    end
    @new_message = Message.new
    @new_message.receiver = @receiver
    @new_message.content = @params[:content]
    @new_message.sender = current_user
    @new_message.save
    flash[:success] = '发送成功。'
    redirect_to request.referer
  end

  def new

  end


  def destroy
  end

end
