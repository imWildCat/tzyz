module UsersHelper
  def current_user_id?(id)
    return current_user.id == id if current_user
    false
  end
  def current_user_or_not_login?(id)
    return current_user.id == id if current_user
    true
  end
end
