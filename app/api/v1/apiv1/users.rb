module APIV1
  class Users < Grape::API

    desc 'user'
    resource 'users' do
      get ':id' do
        @user = User.fetch id: params[:id]
        present @user, with: Entities::User
      end
    end

  end
end