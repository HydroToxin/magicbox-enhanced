# frozen_string_literal: true

module Admin
  class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :is_admin?
    layout 'application'

    add_breadcrumb 'Admin'

    def is_admin?
      # redirect_back fallback_location: root_path, alert: "Admin only" unless current_user.is_admin?
    end
  end
end
