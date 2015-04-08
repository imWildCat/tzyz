module APIV1
  class Users < Grape::API

    desc 'user'
    resource 'user/:id' do
      get do
        @user = User.fetch id: params[:id]
        present @user, with: Entities::User
      end
    end

  end
end