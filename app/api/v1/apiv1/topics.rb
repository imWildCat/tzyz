module APIV1
  class Topics < Grape::API

    desc 'topic list'
    resources :topics do
      get :list do
        @topics = Topic.list(page: current_page, page_size: page_size)
        present @topics, with: Entities::TopicInList
      end

      get ':id' do
        @topic = Topic.find(params[:id])
        present @topic, with: Entities::TopicInList
      end

    end

  end
end