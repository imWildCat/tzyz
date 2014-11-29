module UserHelper
  def user_social_list(user_profile)
    keys = %w(website email qq weibo wechat linkedin zhihu douban renren qzone)
    social_list = []
    keys.each do |k|
      unless user_profile[k].nil? or user_profile[k].to_s.length == 0
        social_list.append({
                               :icon => k,
                               :value => user_profile[k]
                           })
      end
    end
    social_list
  end
end
