# frozen_string_literal: true

module Admin
  # Admin::ResourceDatasController
  class ResourceDatasController < Admin::AdminController
    before_action :set_resource_data, only: %i[show edit update destroy]

    # GET /resource_datas/new
    def new
      @resource_data = ResourceData.new
    end

    def show; end

    def edit; end

    def update; end

    def destroy
      @resource_data.destroy
      respond_to do |format|
        format.html do
          redirect_to admin_resource_datas_url, notice: 'Resource Data was successfully destroyed.'
        end
        format.turbo_stream { head :no_content }
      end
    end

    private

    def resource_data_params
      params.require(:resource_data).permit
    end

    def set_resource_data; end
  end
end
