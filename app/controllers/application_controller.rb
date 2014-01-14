class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:first_name, :last_name, :email, :password, 
    :encrypted_password, :twitter_handle, :linked_in_url, :phone_number, :avatar ) }
  end

  def after_sign_in_path_for(resource)
    if current_user.sign_in_count > 1
      user_path(current_user)
    else
      how_it_works_path
    end
  end

end
