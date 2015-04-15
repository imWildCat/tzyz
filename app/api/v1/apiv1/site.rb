module APIV1
  class Site < Grape::API

    desc 'site'
    resource 'site/init' do
      get do
        topics = Topic.list
        hot_topics = Topic.hots
        hot_nodes = Node.hots
        new_nodes = Node.news

        present({topics: topics, hot_topics: hot_topics,
                 hot_nodes: hot_nodes, new_nodes: new_nodes,
                 statistics: {
                     user_count: User.count_with_cache,
                     topic_count: Topic.count_with_cache,
                     reply_count: Reply.count_with_cache
                 }}, with: Entities::SiteHome)
      end
    end

  end
end