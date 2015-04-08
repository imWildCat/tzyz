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

    def page_size
      size = params[:size].to_i
      [size.zero? ? default_page_size : size, max_page_size].min
    end

  end
end