class UserAvatar < ActiveRecord::Base

  belongs_to :owner, class_name: 'User', foreign_key: :owner_id, touch: true

  after_save :clear_cache_avatar_url

  def url
    return Settings.paths.no_user_avatar unless is_enabled
    return third_party_url unless third_party_url.nil?
    return Settings.paths.user_avatar + filename unless filename.nil?
    Settings.paths.no_user_avatar
  end

  def self.no_user_avatar_url
    Settings.paths.no_user_avatar
  end

  def remove_file
    if !filename.nil?
      # TODO: Remove file in CDN
      require 'rake/file_utils'
      file = File.join('public/images/' + Settings.paths.user_avatar, filename)
      FileUtils.rm_rf file

      self.filename = nil
      save
    end
  end

  def clear_cache_avatar_url
    self.owner.delete_cached_avatar_url
  end

end
