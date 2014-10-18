class UserAvatarController < ApplicationController
  before_action :check_login

  def update
    if params[:avatar].nil?
      flash['warning'] = '请选择要上传的头像。'
      return redirect_to edit_user_profile_path
    end

    extension = params[:avatar].original_filename.split('.').last
    # Check if uploaded file is valid type of image
    if !%w(jpg jpeg gif png).include? extension
      flash['danger'] = '您只能上传 jpg , png , gif 格式的头像。'
      return redirect_to edit_user_profile_path
    end

    # Remove last filename
    current_user.avatar.remove_file

    # Save filename to database
    filename = current_user.id.to_s + '_' + SecureRandom.hex(4) + '.' + extension
    current_user.avatar.filename = filename
    current_user.avatar.save

    # Save file to disk
    require 'rake/file_utils'
    tmp = params[:avatar].tempfile
    file = File.join('public/images/' + Settings.paths.user_avatar, filename)
    FileUtils.cp tmp.path, file
    FileUtils.rm_rf tmp.path

    # After saving
    flash['success'] = '头像修改成功。'
    redirect_to edit_user_profile_path
  end
end
