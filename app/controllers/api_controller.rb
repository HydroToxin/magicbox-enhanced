# frozen_string_literal: true

# ApiController
class ApiController < ActionController::API
  acts_as_token_authentication_handler_for User
  before_action :set_active_storage_host


  def set_active_storage_host
    # Set the host for ActiveStorage URLs
    Rails.application.routes.default_url_options[:host] = request.base_url
  end

  def authenticate_user!
    unless user_signed_in?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
