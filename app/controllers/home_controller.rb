class HomeController < ApplicationController
  def index
    @nodes = Node.all
  end

  def about
  end
end
