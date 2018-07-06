# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :surname, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:sign_in) do |u|
      u.permit(:email, :password)
    end
    devise_parameter_sanitizer.permit(:user_update) do |u|
      u.permit(:name, :surname, :email, :password, :password_confirmation, :current_password)
    end
  end
end
