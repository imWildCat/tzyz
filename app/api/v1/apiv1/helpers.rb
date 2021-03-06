module APIV1
  module Helpers

    def current_page
      page = params[:page]
      page.nil? ? 1 : page.to_i
    end

    def max_page_size
      100
    end

    def default_page_size
      20
    end

    def page_headers!(data)
      header 'current_page', data.current_page
      header 'total_pages', data.total_pages
    end

    def page_size
      size = params[:size].to_i
      [size.zero? ? default_page_size : size, max_page_size].min
    end

    # error

    def error_response!(code: 200, message: 'Error.')
      error!({ :error_code => code, :error_message => message }, code)
    end

    def error_forbidden
      error_response! code: 403, message: '您没有足够的权限进行操作。'
    end

    # auth helpers

    def warden
      env['warden']
    end

    def current_user
      warden.user
    end

    def authenticate!
      error_response!(code: 401, message: '您尚未登录。') unless current_user
    end

    # content helper
    def sanitizer(html)
      crlf = /(\r\n|\n\r|\r|\n)/
      html = html.gsub(crlf, '<br>') # handle \n
      Sanitize.fragment(html, :elements => %w(div blockquote strike a h2 h3 br hr p ol ul li b i u img), :attributes => {'a' => %w(href), 'img' => %w(src), 'p' => %w(data-indent)})
    end

  end
end