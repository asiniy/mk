class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  helper_method :admin_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit! }
  end

  def admin_signed_in?
    current_user.try(:admin?)
  end

  def only_user!
    redirect_to(root_path, error: I18n.t('activerecord.errors.not_admin')) unless user_signed_in?
  end

  def only_admin!
    redirect_to(root_path, error: I18n.t('activerecord.errors.not_admin')) unless admin_signed_in?
  end
end
