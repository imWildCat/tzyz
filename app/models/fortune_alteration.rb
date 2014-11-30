class FortuneAlteration < ActiveRecord::Base
  # Importance: You cannot change the order of reason!
  enum reason: [
           :new_topic, # new topic,                - 10
           :new_reply, # new reply,                - 5
           :edit_topic, # edit topic,              - 5
           :edit_reply, # edit reply,              - 5
           :quote_reply, # quote reply,            - 1
           :mention_user, # mention user,          - 1
           :send_message, # send message,          - 1
           :topic_replied, # topic replied,        + 5
           :topic_appreciated, # topic appreciated, + 10
           :reply_appreciated, # reply appreciated, + 10
           :daily_login, # daily login, random
           :new_user, # new user, + 50
       ]

  belongs_to :fortune_alterable, polymorphic: true
  belongs_to :user

  before_create :caculate_alteration
  after_create :perform_alteration

  def caculate_alteration
    case reason
      when 'new_topic'
        self.quantity = -10
      when 'new_reply'
        self.quantity = -5
      when 'edit_topic'
        self.quantity = -5
      when 'edit_reply'
        self.quantity = -5
      when 'quote_reply'
        self.quantity = -1
      when 'mention_user'
        self.quantity = -1
      when 'send_message'
        self.quantity = -1
      when 'topic_replied'
        self.quantity = 5
      when 'topic_appreciated'
        self.quantity = 10
      when 'reply_appreciated'
        self.quantity = 10
      when 'daily_login'
        self.quantity = daily_login
      when 'new_user'
        self.quantity = 50
    end
  end

  def perform_alteration
    self.user.fortune += quantity
    self.user.save
  end

  # Create a random for daily login
  def daily_login
    rand(20..60)
  end
end
