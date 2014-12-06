class Cpanel::UsersController < Cpanel::ApplicationController
  include ApplicationHelper

  def show
    @users = User.order(id: :asc).paginate(page: current_page, per_page: 15)
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    user_new_data = params.require(:user).permit(:nickname, :email, :group)
    user = User.find params[:id]

    user.assign_attributes_with_log user_new_data, current_user

    if user.save
      flash[:success] = '用户修改成功。'
    else
      flash[:error] = '用户更新失败。'
    end

    redirect_to cpanel_users_path

    # node_new_data = params.require(:node).permit(:node_category_id, :name, :slug)
    # node = Node.find params[:id]
    #
    # node.assign_attributes_with_history node_new_data, current_user
    #
    # if node.save
    #   flash[:success] = '节点更新成功。'
    # else
    #   flash[:error] = '更新失败，请联系开发组。'
    # end
    # redirect_to cpanel_nodes_path
  end

end
