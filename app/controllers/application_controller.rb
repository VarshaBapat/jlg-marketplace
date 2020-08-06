class ApplicationController < ActionController::Base

    require 'date'

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.admin?
      redirect_to admin_path(current_user.admin.id), :alert => exception.message
    elsif current_user.seller?
      redirect_to seller_path(current_user.seller.id), :alert => exception.message
    elsif current_user.student?
      redirect_to customer_path(current_user.customer.id), :alert => exception.message
    end
  end
  
  def format_phone_number(number)
    x = number.to_s.delete('^0-9')
    return x
  end

  def user_details_are_empty
    if current_user.admin?
      return true if any_attributes_are_empty(current_user.admin)
    elsif current_user.seller?
      return true if any_attributes_are_empty(current_user.seller)
    elsif current_user.customer?
      return true if any_attributes_are_empty(current_user.customer)
    end
  end

  def any_attributes_are_empty(person)
      person.attributes.each do |attr_name, attr_val|
        puts "name = #{attr_name}"
        puts "value = #{attr_val}"
        puts "empty" if attr_val == ""
        return true if attr_val == ""
      end
  end




   

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:role, :email, :password, :password_confirmation)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password)}
    end

    def after_sign_out_path_for(resource)
      home_path
    end
end
© 2020 GitHub, Inc.
end
