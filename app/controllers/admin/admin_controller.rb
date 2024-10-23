# frozen_string_literal: true

module Admin
  # Admin::AdminController
  class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :admin?
    layout 'application'

    add_breadcrumb 'Admin'

    def admin?
      # redirect_back fallback_location: root_path, alert: "Admin only" unless current_user.admin?
    end
  end
end
