# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  layout 'application'

  protect_from_forgery prepend: true
  skip_before_action :verify_authenticity_token, if: lambda {
    controller_name == 'sessions' && action_name == 'create'
  }

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  #add_breadcrumb '<i class="fa fa-home"></i>'.html_safe, :root_path

  def after_sign_in_path_for(_resource)
    dashboard_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[username email password password_confirmation
                                               current_password avatar])
  end
end
