module APIV1
  class Accounts < Grape::API

    desc 'accounts'
    resource 'accounts' do
      get :login do
        unless current_user
          account = params[:account]
          password = params[:password]

          valid_user = User.authenticate(account: account, password: password)
          warden.set_user valid_user
          {
              current_user: current_user
          }
        else
          error_response! message: '您已登录。'
        end
      end

      get :logout do
        authenticate!
        warden.logout
        {}
      end
    end

  end
end