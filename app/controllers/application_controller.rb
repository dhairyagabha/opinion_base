class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:home_controller]




  private

  def user_time_zone(&block)
    if current_user.present?
      Time.use_zone(current_user.time_zone, &block)
    else
      Time.use_zone('Central Time (US & Canada)', &block)
    end
  end

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
