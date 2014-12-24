class UserLoginHistory < ActiveRecord::Base

  belongs_to :user

  after_create :generate_daily_login

  def generate_daily_login
    day = UserDailyLogin::day_of_today
    daily_login = UserDailyLogin::find_by user_id: user_id, day: day
    if daily_login.nil?
      UserDailyLogin::create user_id: user_id, day: day
    end
  end

end
