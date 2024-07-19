class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  add_flash_types :warning, :success, :danger, :info, :alert

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}

      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
  end

  private

  def user_not_authorized
    flash[:alert] = "Você Não possui permissão para acessar essa página"
    redirect_back_or_to(root_path)
  end
end
