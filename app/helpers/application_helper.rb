module ApplicationHelper

  def title(page_title)
    site_name = '滕州一中校友会'
    title = page_title.to_s ? "#{ page_title.to_s} - #{site_name}" : site_name rescue 'SITE_NAME'
    content_for :title, content_tag('title', title, nil, false)
  end

  def timeago(time, options = {})
    options[:class] = options[:class].blank? ? 'timeago' : [options[:class], 'timeago'].join(' ')
    options.merge!(title: time.iso8601)
    content_tag(:abbr, '', class: options[:class], title: time.iso8601) if time
  end

  def sanitizer(html)
    Sanitize.fragment(html, :elements => %w(div blockquote strike a h2 h3 br hr p ol ul li b i u img), :attributes => {'a' => %w(href), 'img' => %w(src), 'p' => %w(data-indent)})
  end

  def render_will_paginate(resources, css_class: '')
    # TODO: add support for options
    will_paginate resources, renderer: BootstrapPagination::Rails, class: css_class
  end

  def render_mentioned_users(content)
    content = content.gsub(/@[\u4e00-\u9fa5\w]{1,20}\[\d{1,10}\]/) { |mention|
      mentioned_user_id = /\[(\d{1,10})(\])/.match(mention)[1]
      user = User.cached_info mentioned_user_id
      return "@#{link_to user.display_name, user}".html_safe if user
      mention
    }
    content.html_safe
  end

  def count_or_none(count)
    if count > 0
      count
    else
      ''
    end
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
