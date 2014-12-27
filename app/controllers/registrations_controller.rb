class RegistrationsController < Devise::RegistrationsController

  before_action :permit_nickname

  def new
    add_breadcrumb '注册'

    build_resource(session[:'devise.user_attributes'])
    test = self.resource
    puts self.resource

    @validatable = devise_mapping.validatable?
    if @validatable
      @minimum_password_length = resource_class.password_length.min
    end
    respond_with self.resource
  end

  def create
    build_resource(sign_up_params)

    resource.nickname = params[resource_name][:nickname]

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)

        # Bind social login
        auth = Authorization.find_by_id session[:auth_id]
        puts auth
        unless auth.nil?
          auth.user_id = resource.id
          auth.save
        end

        # Get avatar image url
        resource.avatar.update_attributes(:third_party_url => auth.image ) unless auth.image.nil? or auth.image == ''

        # Send email
        EmailConfirmationWorker::perform_async resource.id

        # Record login history
        resource.after_database_authentication

        # Clear session for `devise.user_attributes`
        session[:'devise.user_attributes'] = nil


        # respond_with resource, location: after_sign_up_path_for(resource) # Rediect loop
        redirect_to root_path
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
  end

  def edit
    add_breadcrumb '个人中心'
    add_breadcrumb '修改密码'

    super
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    super
    # self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    # # prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    #
    # resource_updated = update_resource(resource, account_update_params)
    # yield resource if block_given?
    # if resource_updated
    #   # if is_flashing_format?
    #   #   flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
    #   #       :update_needs_confirmation : :updated
    #   #   set_flash_message :notice, flash_key
    #   # end
    #   flash[:success] = '密码修改成功。'
    #   sign_in resource_name, resource, bypass: true
    #   respond_with resource, location: after_update_path_for(resource)
    # else
    #   clean_up_passwords resource
    #   respond_with resource
    # end
  end

  def destroy
    flash[:warning] = '您不能删除自己的帐号。'
    redirect_to root_path
  end



  private
  def permit_nickname
    devise_parameter_sanitizer.for(:sign_up) << :nickname
  end
end
