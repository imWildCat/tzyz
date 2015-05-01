module APIV1
  class NodeCategories < Grape::API

    desc 'node category list'
    resources :node_categories do
      get 'list' do

        present NodeCategory.fetch_list, with: Entities::NodeCategory
      end

    end
  end
end