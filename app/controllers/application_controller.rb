class ApplicationController < ActionController::API
  # before_action :set_headers
  acts_as_token_authentication_handler_for User, fallback: :none

  # private

  # def set_headers
  #   response.headers['Content-Type'] = 'application/json'
  # end
end
