class UserDailyLogin < ActiveRecord::Base

  belongs_to :user

  before_create :generate_day, :generate_successive_days
  after_save :clear_user_cache

  def generate_day
    self.day = UserDailyLogin::day_of_today
  end

  def generate_successive_days
    yesterday = UserDailyLogin::day_of_yesterday
    login_yesterday = UserDailyLogin::find_by user_id: user_id, day: yesterday
    unless login_yesterday.nil?
      self.successive_days = login_yesterday.successive_days + 1
    end
  end

  def clear_user_cache
    self.user.clear_daily_awarded
  end

  def self.day_of_today
    timezone_now = Time.zone.now
    timezone_now.year * 10000 + timezone_now.month * 100 + timezone_now.day
  end

  def self.day_of_yesterday
    timezone_yesterday = Time.zone.yesterday
    timezone_yesterday.year * 10000 + timezone_yesterday.month * 100 + timezone_yesterday.day
  end

end
