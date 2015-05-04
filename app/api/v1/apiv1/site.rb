module APIV1
  class Site < Grape::API

    desc 'site'
    resource 'site/init' do
      get do
        topics = Topic.list page: current_page
        hot_topics = Topic.hots
        hot_nodes = Node.hots
        new_nodes = Node.news

        page_headers! topics

        present({topics: topics, hot_topics: hot_topics,
                 hot_nodes: hot_nodes, new_nodes: new_nodes,
                 current_user: current_user,
                 statistics: {
                     user_count: User.count_with_cache,
                     topic_count: Topic.count_with_cache,
                     reply_count: Reply.count_with_cache,
                 }}, with: Entities::SiteHome)
      end
    end

  end
end