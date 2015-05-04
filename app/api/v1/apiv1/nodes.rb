module APIV1
  class Nodes < Grape::API

    desc 'node topic list'
    resources :nodes do
      get ':slug' do
        node = Node.find_by_slug(params[:slug]) or not_found
        topics = node.paginated_topics_for_page(current_page)
        page_headers! topics
        present({topics: topics, node: node}, with: Entities::SingleNode)
      end


    end

  end
end