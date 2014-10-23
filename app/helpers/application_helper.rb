module ApplicationHelper

  def title(page_title)
    site_name = '滕州一中校友会'
    title = page_title.to_s ? "#{ page_title.to_s} - #{site_name}" : site_name rescue 'SITE_NAME'
    content_for :title, content_tag('title', title, nil, false)
  end

  def current_page
    page = params[:page]
    page.nil? ? 1 : page.to_i
  end

  def not_login(m = '请登录后再进行操作')
    if current_user
      nil
    else
      flash[:warning] = m
      redirect_to new_user_session_path
    end
  end
end
