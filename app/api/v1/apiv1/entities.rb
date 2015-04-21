module APIV1

  module Entities

    # class UserAvatar < Grape::Entity
    #   expose :url do |model, opts|
    #     # http://stackoverflow.com/questions/19356935/host-and-port-in-a-grape-entity
    #     if model.url.start_with? 'no_avatar'
    #       "//#{opts[:env]['HTTP_HOST']}/assets/#{model.url}"
    #     else
    #       "//#{opts[:env]['HTTP_HOST']}/images/#{model.url}"
    #     end
    #   end
    # end

    class UserInList < Grape::Entity
      expose :id, :nickname, :display_name, :group, :role, :topic_count, :reply_count, :created_at
      expose :avatar_url
      # expose :avatar, using: Entities::UserInListAvatar
    end

    class UserProfile < Grape::Entity
      expose :name, :gender, :headline, :field, :company, :university, :city, :website, :email, :introduction
    end

    class User < Grape::Entity
      expose :id, :nickname, :display_name, :group, :role, :topic_count, :reply_count, :created_at, :avatar_url
      expose :profile, using: Entities::UserProfile
    end

    class Node < Grape::Entity
      expose :id, :node_category_id, :name, :slug, :description, :min_group, :min_role
    end

    class TopicInList < Grape::Entity
      expose :id, :title, :click_count, :reply_count, :favorite_count, :appreciation_count, :created_at, :priority
      expose :node, using: Entities::Node
      expose :author, using: Entities::UserInList
      expose :refresher, using: Entities::UserInList
    end

    class Topic < Grape::Entity
      expose :id, :title, :status, :created_at, :priority, :click_count, :reply_count,
             :favorite_count, :appreciation_count, :content
      expose :node, using: Entities::Node
      expose :author, using: Entities::UserInList
    end

    class Reply < Grape::Entity
      expose :id, :content, :position, :appreciation_count, :created_at
      expose :author, using: Entities::UserInList
      expose :quoted_reply, using: Entities::Reply
    end

    class SingleNode < Grape::Entity
      expose :node, using: Entities::Node
      expose :topics, using: Entities::Topic
    end

    class SingleTopic < Grape::Entity
      expose :topic, using: Entities::Topic
      expose :replies, using: Entities::Reply
    end

    class SiteHome < Grape::Entity
      expose :topics, using: Entities::TopicInList
      expose :hot_topics, using: Entities::TopicInList
      expose :hot_nodes, using: Entities::Node
      expose :new_nodes, using: Entities::Node
      expose :statistics
    end


  end
end
