class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_permitted_parameters_update, if: :author_controller?
  around_action :user_time_zone

  def after_sign_in_path_for(resource)
    articles_path
  end


  private

  def author_controller?
    if controller_name == 'author'
      true
    else
      false
    end
  end

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

  def configure_permitted_parameters_update
      devise_parameter_sanitizer.permit(:update, keys: [:avatar, :username, :name, :description, :facebook, :instagram, :twitter, :pinterest, :time_zone])
  end
end