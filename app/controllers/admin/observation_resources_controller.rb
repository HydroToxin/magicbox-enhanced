# frozen_string_literal: true

module Admin
  # Admin::ObservationResourcesController
  class ObservationResourcesController < Admin::AdminController
    before_action :set_observation_resource, only: %i[show edit update destroy]
    before_action :set_grow, only: %i[new create]

    # GET /observation_resources/new
    def new
      @observation_resource = ObservationResource.new
    end

    def destroy
      @observation_resource.destroy
      respond_to do |format|
        format.html do
          redirect_to admin_observation_resources_url, notice: 'ObservationResource was successfully destroyed.'
        end
        format.turbo_stream { head :no_content }
      end
    end

    private

    def observation_resource_params
      params.require(:observation_resource).permit
    end

    def set_observation_resource
      @observation_resource = ObservationResource.find(params[:id])
    end

    def set_grow
      return if params[:observation][:grow_id].nil?

      @grow = Grow.find(params[:observation][:grow_id])
    end
  end
end
