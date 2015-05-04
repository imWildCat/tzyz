module APIV1
  class Topics < Grape::API

    desc 'topic list'
    resources :topics do
      get :list do
        @topics = Topic.list(page: current_page, page_size: page_size)
        page_headers! @topics
        present @topics, with: Entities::TopicInList
      end

      get ':id' do
        topic = Topic.find(params[:id])
        replies = topic.show(current_page, true)
        present({topic: topic, replies: replies}, with: Entities::SingleTopic)
      end

      # params: :title, :node_id, :content(optional)
      post :create do
        authenticate!

        if params[:title].blank?
          error_response!(message: '标题不能为空。')
        end
        node = Node.find_by_id(params[:node_id]) or error_response!(message: '请选择一个节点。')
        topic = node.topics.new(title: params[:title], author_id: current_user.id, content: sanitizer(params[:content]))

        if topic.save
          {
              result: true,
              topic_id: topic.id
          }
        else
          error_response!(message: '创建主题过程中出现未知错误。')
        end
      end

      post ':id/reply' do
        authenticate!
        topic = Topic.find(params[:id]) or error_response!(message: '未找到话题。')
        content = sanitizer(params[:content])
        quoted_reply_id = params[:quoted_reply_id].to_i

        if content.to_s.blank?
          error_response!(message: '回复内容为空，请输入您的内容。')
        end

        reply = Reply.new(topic_id: topic.id, author_id: current_user.id,
                          content: content)
        reply.position = topic.reply_count + 1

        # handle priority
        # TODO: find a more friendly way to sort the topics
        if topic.created_at > 1.days.ago
          topic.priority = Time.now
        elsif topic.created_at > 3.days.ago
          delta = (Time.now - topic.created_at) * 0.0009
          # delta = 180 if delta > 180
          topic.priority = Time.now - delta
        elsif topic.created_at > 7.days.ago
          delta = (Time.now - topic.created_at) * 0.0015
          delta = 3600 if delta > 3600
          topic.priority = Time.now - delta
        end
        topic.save

        # Handle quoted reply
        if quoted_reply_id > 0
          quoted_reply = Reply.find(quoted_reply_id)
          reply.quoted_reply = quoted_reply if quoted_reply.topic_id == topic.id
        end

        if reply.save
          # If new reply has a quoted_reply, and the authors of them are NOT the same, send notification
          if reply.quoted_reply and (reply.author_id != reply.quoted_reply.author_id)
            reply.notifications.create receiver: reply.quoted_reply.author, n_type: :reply_quoted
          end

          {
              result: true,
              topic_id: topic.id,
              reply_id: reply.id
          }
        else
          error_response!(message: '创建回复过程中出现未知错误。')
        end
      end

    end

  end
end