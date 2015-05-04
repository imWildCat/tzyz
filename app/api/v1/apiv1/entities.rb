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
      expose :id, :name, :slug, :description, :min_role
      # expose :node_category_id, :min_group,
    end

    class NodeCategory < Grape::Entity
      expose :id, :name, :slug
      expose :nodes, using: Entities::Node
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

    class ReplyWithTopic < Grape::Entity
      expose :id, :content, :position, :appreciation_count, :created_at
      expose :author, using: Entities::UserInList
      expose :quoted_reply, using: Entities::Reply
      expose :topic, using: Entities::TopicInList
    end

    class SingleNode < Grape::Entity
      expose :node, using: Entities::Node
      expose :topics, using: Entities::Topic
    end

    class SingleTopic < Grape::Entity
      expose :topic, using: Entities::Topic
      expose :replies, using: Entities::Reply
    end

    # class Appreciation < Grape::Entity
    #   expose :id
    #   expose :user, using: Entities::UserInList
    #   expose :topic, using: Entities::TopicInList,
    #          if: lambda { |status, options|
    #                  status.appreciative_type == 'Topic' } do |status, options|
    #     status.appreciative
    #   end
    #
    #   expose :reply, using: Entities::ReplyWithTopic,
    #          if: lambda { |status, options|
    #            status.appreciative_type == 'Reply' } do |status, options|
    #     status.appreciative
    #   end
    # end

    class Notification < Grape::Entity
      expose :id, :n_type, :is_read, :reason_id, :created_at

      expose :related_content do |status, options|
        if status.notifiable_type == 'Topic' or status.notifiable_type == 'Reply'
          status.notifiable.content
        elsif status.notifiable_type == 'Appreciation'
          status.notifiable.appreciative.content
        elsif status.n_type == 'user_welcome'
          '请遵守社区规范，希望您享受在这个社区的美好时光 : )'
        else
          ''
        end
      end

      expose :related_topic, using: Entities::TopicInList do |status, options|
        if status.notifiable_type == 'Topic'
          status.notifiable
        elsif status.notifiable_type == 'Reply'
          status.notifiable.topic
        elsif status.notifiable_type == 'Appreciation'
          if status.notifiable.appreciative_type == 'Topic'
            status.notifiable.appreciative
          elsif status.notifiable.appreciative_type == 'Reply'
            status.notifiable.appreciative.topic
          end
        else
          nil
        end
      end

      expose :related_user, using: Entities::UserInList do |status, options|
        if status.notifiable_type == 'Topic' or status.notifiable_type == 'Reply'
          status.notifiable.author
        elsif status.notifiable_type == 'Appreciation'
          status.notifiable.user
        else
          nil
        end
      end


      # expose :topic, using: Entities::TopicInList,
      #        if: lambda { |status, options|
      #          status.notifiable_type == 'Topic' } do |status, options|
      #   status.notifiable
      # end
      #
      # expose :reply, using: Entities::ReplyWithTopic,
      #        if: lambda { |status, options|
      #          status.notifiable_type == 'Reply' } do |status, options|
      #   status.notifiable
      # end
      #
      # expose :appreciation, using: Entities::Appreciation,
      #        if: lambda { |status, options|
      #          status.notifiable_type == 'Appreciation' } do |status, options|
      #   status.notifiable
      # end

    end

    class FortuneAlterations < Grape::Entity
      expose :quantity, :balance, :reason, :created_at
    end


    class SiteHome < Grape::Entity
      expose :topics, using: Entities::TopicInList
      expose :hot_topics, using: Entities::TopicInList
      expose :hot_nodes, using: Entities::Node
      expose :new_nodes, using: Entities::Node
      expose :current_user, using: Entities::User
      expose :statistics
    end


  end
end
