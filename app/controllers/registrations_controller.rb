class RegistrationsController < Devise::RegistrationsController

  before_action :authenticate_user!, except: [:new, :create]

  def new
    super
  end

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?

      # # We know that the user has been persisted to the database, so now we can create our empty profile
      if resource.customer?
        resource.create_customer!(first_name: "", last_name: "", address: "", phone: "")
      elsif resource.seller?
        resource.create_seller!(first_name: "", last_name: "", address: "", phone: "", business_number: "")
      elsif resource.admin?
        resource.create_admin!(first_name: "", last_name: "")
      end
 

      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end

  end

  def edit
    super
  end

  def update
    super
  end



  private

    def after_sign_up_path_for(current_user)

      if current_user.customer?
        edit_customer_path(current_user.customer.id)
      elsif current_user.seller?
        edit_seller_path(current_user.seller.id)
      elsif current_user.admin?
        edit_admin_path(current_user.admin.id)
      end
    end
  
end 