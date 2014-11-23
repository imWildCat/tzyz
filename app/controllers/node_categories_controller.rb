class NodeCategoriesController < ApplicationController
  include ApplicationHelper

  def show
    @slug = params[:slug]

    if @slug.nil?
      not_found
    end

    @node_category = NodeCategory.find_by_slug(@slug) || not_found

    # Data will be rendered :
    @node_categories = NodeCategory.cached_cats
    @topics = Rails.cache.fetch("node_category_#{@slug}_topics_page_#{@page}", expires_in: 20.seconds) do
      @node_category.topics(page: current_page)
    end

    add_breadcrumb '节点分类'
    add_breadcrumb @node_category.name

  end

  def all
    add_breadcrumb '节点导航'
    @node_categories = Rails.cache.fetch('all_categories', expires_in: 1.day) do
      NodeCategory::includes(:nodes).all
    end
  end

end
