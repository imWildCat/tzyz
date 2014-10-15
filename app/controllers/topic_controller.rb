class TopicController < ApplicationController
  def show
    id = params['id']
    @topic = Topic.find(id)
  end

end
