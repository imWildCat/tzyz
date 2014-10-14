module ApplicationHelper

  def title(page_title)
    site_name = '滕州一中校友会'
    title = page_title.to_s ? "#{ page_title.to_s} - #{site_name}" : site_name rescue 'SITE_NAME'
    content_for :title, content_tag('title', title, nil, false)
  end
end
