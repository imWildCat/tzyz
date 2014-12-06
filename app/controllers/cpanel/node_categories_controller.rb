class Cpanel::NodeCategoriesController < Cpanel::ApplicationController
  include ApplicationHelper

  def show
    @node_categories = NodeCategory.order(id: :asc).paginate(page: current_page, per_page: 10)
  end

  def new
    @node_category = NodeCategory.new
  end

  def create
    new_node_category_data = params.require(:node_category).permit(:name, :slug)

    new_node_category = NodeCategory.create new_node_category_data

    if new_node_category.valid?
      flash[:success] = '创建成功。'
      generate_creating_history(new_node_category)
    else
      flash[:error] = '创建失败，可能是因为包含已有内容。'
    end
    redirect_to cpanel_node_categories_path
  end

  def edit
    @node_category = NodeCategory.find params[:id]
  end

  def update
    node_category_new_data = params.require(:node_category).permit(:name, :slug)
    node_category = NodeCategory.find params[:id]
    node_category.assign_attributes_with_history node_category_new_data, current_user

    if node_category.save
      flash[:success] = '节点分类更新成功。'
    else
      flash[:error] = '更新失败，请联系开发组。'
    end
    redirect_to cpanel_node_categories_path
  end

end
