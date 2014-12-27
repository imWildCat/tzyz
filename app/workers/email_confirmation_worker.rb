class EmailConfirmationWorker
  include Sidekiq::Worker

  sidekiq_options :queue => :email, :retry => 5

  def perform(user_id)
    user = User.find user_id
    user.send_confirmation_instructions
  end

end
