class FortuneAlteration < ActiveRecord::Base

  # Importance: You cannot change the order of reason!
  def self.reason_permitted(return_dic = false)
    reasons = {
        new_topic: -10, # new topic,                - 10
        new_reply: -5, # new reply,                - 5
        edit_topic: -5, # edit topic,              - 5
        edit_reply: -5, # edit reply,              - 5
        quote_reply: -1, # quote reply,            - 1
        mention_user: -1, # mention user,          - 1
        send_message: -1, # send message,          - 1
        topic_replied: 5, # topic replied,        + 5
        topic_appreciated: 10, # topic appreciated, + 10
        send_topic_appreciation: -10,
        reply_appreciated: 10, # reply appreciated, + 10
        send_reply_appreciation: -10,
        daily_login: 0, # daily login, random
        new_user: 50, # new user, + 50
    }
    unless return_dic
      return reasons.keys
    else
      return reasons
    end
  end

  enum reason: reason_permitted

  belongs_to :fortune_alterable, polymorphic: true
  belongs_to :user

  before_create :perform_alteration


  def perform_alteration
    case reason
      when 'daily_login'
        self.quantity = daily_login
      else
        self.quantity = FortuneAlteration.reason_permitted(true)[reason.to_sym]
    end
    self.balance = self.user.fortune += quantity
    self.user.save
  end

  # Create a random for daily login
  def daily_login
    rand(20..60)
  end
end
