# frozen_string_literal: true

module Admin
  # Admin::IssuesController
  class IssuesController < Admin::AdminController
    before_action :set_issue, only: %i[show edit update destroy]

    def new
      @issue = Issue.new
    end

    def destroy
      @issue.destroy
      respond_to do |format|
        format.html do
          head :no_contentx
        end
        format.turbo_stream { head :no_content }
      end
    end

    private

    def issue_params
      params.require(:resource_data).permit
    end

    def set_issue
      @issue = Issue.find(params[:id])
    end
  end
end
