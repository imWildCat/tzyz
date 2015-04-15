module APIV1

  module Entities

    class UserAvatar < Grape::Entity
      expose :url do |model, opts|
        # http://stackoverflow.com/questions/19356935/host-and-port-in-a-grape-entity
        if model.url.start_with? 'no_avatar'
          "//#{opts[:env]['HTTP_HOST']}/assets/#{model.url}"
        else
          "//#{opts[:env]['HTTP_HOST']}/images/#{model.url}"
        end
      end
    end

    class User < Grape::Entity
      expose :id, :nickname, :display_name, :group, :role, :topic_count, :reply_count, :created_at
      expose :avatar, using: Entities::UserAvatar
    end

    class Node < Grape::Entity
      expose :id, :node_category_id, :name, :slug, :description, :min_group, :min_role
    end

    class TopicInList < Grape::Entity
      expose :id, :title, :click_count, :reply_count, :favorite_count, :appreciation_count, :created_at, :priority
      expose :node, using: Entities::Node
      expose :author, using: Entities::User
      expose :refresher, using: Entities::User
    end

    class Topic < Grape::Entity
      expose :id, :title, :status, :created_at, :priority, :click_count, :reply_count,
             :favorite_count, :appreciation_count, :content
      expose :node, using: Entities::Node
      expose :author, using: Entities::User
    end


  end
end
