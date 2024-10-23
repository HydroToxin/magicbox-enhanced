# frozen_string_literal: true

module Admin
  # Admin::IssuesController
  class IssuesController < Admin::AdminController
    before_action :set_issue, only: %i[show edit update destroy]

    # GET /resource_datas/new
    def new
      @issue = Issue.new
    end

    def show; end

    def edit; end

    def update; end

    def destroy
      @issue.destroy
      respond_to do |format|
        format.html do
          redirect_to admin_issue_datas_url, notice: 'Issue was successfully destroyed.'
        end
        format.turbo_stream { head :no_content }
      end
    end

    private

    def rissue_params
      params.require(:resource_data).permit
    end

    def set_issue; end
  end
end
