class UserAvatar < ActiveRecord::Base

  belongs_to :owner, class_name: 'User', foreign_key: :owner_id

  def url
    return Settings.paths.no_user_avatar unless is_enabled
    return ttk_url if !ttk_url.nil? && Settings.services.tietuku
    return Settings.paths.user_avatar + filename unless filename.nil?
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
end
