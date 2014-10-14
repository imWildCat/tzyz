class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    resource.nickname = params[resource_name][:nickname]

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end

    # build_resource(sign_up_params)
    # resource.nickname = params[resource_name][:nickname]
    # resource.email = params[resource_name][:email]
    # if resource.save
    #   if resource.active_for_authentication?
    #     set_flash_message :notice, :signed_up if is_navigational_format?
    #     sign_in(resource_name, resource)
    #     respond_with resource, location: after_sign_up_path_for(resource)
    #   else
    #     set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
    #     expire_data_after_sign_in!
    #     respond_with resource, location: after_inactive_sign_up_path_for(resource)
    #   end
    # else
    #   clean_up_passwords resource
    #   respond_with resource
    # end
  end

  def destroy
    flash[:warning] = '您不能删除自己的帐号。'
    redirect_to root_path
  end


end
