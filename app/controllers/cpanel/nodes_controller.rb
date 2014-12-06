class Cpanel::NodesController < Cpanel::ApplicationController
  include ApplicationHelper

  def show
    @nodes = Node.order(id: :asc).includes(:node_category).paginate(page: current_page, per_page: 15)
  end

  def new
    @node = Node.new
  end

  def create
    new_node_data = params.require(:node).permit(:node_category_id, :name, :slug)

    new_node = Node.create new_node_data

    if new_node.valid?
      flash[:success] = '创建成功。'
      generate_creating_history(new_node)
    else
      flash[:error] = '创建失败，可能是因为包含已有内容。'
    end
    redirect_to cpanel_nodes_path
  end

  def edit
    @node = Node.find params[:id]
  end

  def update
    node_new_data = params.require(:node).permit(:node_category_id, :name, :slug)
    node = Node.find params[:id]

    node.assign_attributes_with_history node_new_data, current_user

    if node.save
      flash[:success] = '节点更新成功。'
    else
      flash[:error] = '更新失败，请联系开发组。'
    end
    redirect_to cpanel_nodes_path
  end

end
