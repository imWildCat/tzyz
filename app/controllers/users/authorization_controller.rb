class Users::AuthorizationController < ApplicationController

  def destroy
    provider = params[:provider]

    authorization = current_user.authorizations.where(provider: provider).first
    authorization.update_attributes(user_id: nil)

    authorization_name = User::SOCIALS[authorization.provider.to_sym]
    flash[:success] = "已解除您帐号与 #{authorization_name} 的绑定。"

    redirect_to :back
  end

end