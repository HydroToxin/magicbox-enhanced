# frozen_string_literal: true

module Admin
  # Admin::AdminController
  class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :admin?
    layout 'application'

    def admin?
      redirect_back fallback_location: root_path, alert: "Admin only" if !current_user.admin?
    end
  end
end
