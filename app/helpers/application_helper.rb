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

  def render_will_paginate(resources)
    # TODO: add support for options
    will_paginate resources, renderer: BootstrapPagination::Rails
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
end
