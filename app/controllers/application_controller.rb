# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :authenticate_user!

  protected

  def set_locale
    I18n.default_locale = validated_locale
  end

  def validated_locale
    locale = params[:locale].to_s.strip.to_sym
    if I18n.available_locales.include?(locale)
      locale
    else
      I18n.default_locale
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :surname, :email, :password, :password_confirmation, :role, :group_id)
    end
    devise_parameter_sanitizer.permit(:sign_in) do |u|
      u.permit(:email, :password)
    end
    devise_parameter_sanitizer.permit(:user_update) do |u|
      u.permit(:name, :surname, :email, :password, :password_confirmation, :current_password)
    end
  end
end
