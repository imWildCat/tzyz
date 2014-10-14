class SessionsController < Devise::SessionsController
  def new
    super
    session['user_return_to'] = request.referrer
  end
end
