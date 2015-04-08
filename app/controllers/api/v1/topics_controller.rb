module API::V1
  class TopicsController < ApplicationController

    def show
      Topic.all
    end
  end
end
