module APIV1
  class Accounts < Grape::API

    desc 'accounts'
    resource 'accounts' do
      post :login do
        # TODO: lockable is disabled. Find a way to implemnt it
        unless current_user
          account = params[:account]
          password = params[:password]

          valid_user = User.authenticate(account: account, password: password)
          if valid_user
            warden.set_user valid_user
            {
                current_user: current_user
            }
          else
            error_response! message: '用户名或密码错误。'
          end

        else
          error_response! message: '您已登录。'
        end
      end

      post :logout do
        authenticate!
        warden.logout
        {result: true}
      end

      post :reg do
        new_user = User.new
        new_user.nickname = params[:nickname]
        new_user.password = params[:password]
        new_user.email = params[:email]

        if new_user.valid?
          new_user.save

          # send email
          EmailConfirmationWorker::perform_async new_user.id

          # sign in
          warden.set_user new_user

          {
              current_user: new_user
          }
        else
          error_response! message: new_user.errors.messages.first.second.first.to_s
        end
      end
    end

  end
end