class Cpanel::NodeCategoriesController < Cpanel::ApplicationController
  include ApplicationHelper

  def show
    @node_categories = NodeCategory.order(id: :asc).paginate(page: current_page, per_page: 10)
  end

end
