class ApplicationController < ActionController::API
  # before_action :set_headers
  acts_as_token_authentication_handler_for User, fallback: :none

  # private

  # def set_headers
  #   response.headers['Content-Type'] = 'application/json'
  # end

  # protected
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up) do |user_params|
  #     user_params.permit(:username, :email, :password, :password_confirmation, :role)
  #   end
  # end
end
