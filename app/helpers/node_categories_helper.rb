module NodeCategoriesHelper

  def tab_selected(slug)
    @slug = params[:slug] || nil
    if slug == @slug
      'selected'
    elsif @slug.nil? && slug == 'home'
      'selected'
    else
      ''
    end
  end
end
