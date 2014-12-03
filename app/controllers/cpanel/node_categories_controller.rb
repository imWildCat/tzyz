class Cpanel::NodeCategoriesController < Cpanel::ApplicationController
  include ApplicationHelper

  def show
    @node_categories = NodeCategory.order(id: :asc).paginate(page: current_page, per_page: 10)
  end

  def edit
    @node_category = NodeCategory.find params[:id]
  end

  def update
    node_category = params.require(:node_category).permit(:name, :slug)
    if NodeCategory.update params[:id], node_category
      flash[:success] = '节点分类更新成功。'
    else
      flash[:error] = '更新失败，请联系开发组。'
    end
    redirect_to cpanel_node_categories_path
  end

end
