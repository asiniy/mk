class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  helper_method :signed_in_as_admin?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit! }
  end

  def signed_in_as_admin?
    current_user.try(:admin?)
  end

  def only_admin!
    redirect_to(root_path, error: I18n.t('activerecord.errors.not_admin')) unless signed_in_as_admin?
  end
end
