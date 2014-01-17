class RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    how_it_works_path
  end

end