module APIV1
  class Topics < Grape::API

    desc 'topic list'
    resources :topics do
      get :list do
        @topics = Topic.list(page: current_page, page_size: page_size)
        present @topics, with: Entities::TopicInList
      end

      get ':id' do
        topic = Topic.find(params[:id])
        replies = topic.show(current_page, true)
        present({topic: topic, replies: replies}, with: Entities::SingleTopic)
      end

    end

  end
end