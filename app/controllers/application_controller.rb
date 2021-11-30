class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end

  def after_sign_in_path_for(audition)
    if current_user.role == "Manager"
      auditions_path
    elsif current_user.role == "Artist"
      new_audition_path
   end
  end
end
