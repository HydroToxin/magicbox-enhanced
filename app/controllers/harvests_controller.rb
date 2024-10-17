class HarvestsController < ApplicationController

  before_action :set_grow, only: [:index]
  before_action :set_harvest, only: [:index]

  private
    def set_grow
      @grow = Grow.find(params[:grow_id])

      add_breadcrumb "Grow ##{@grow.id}", @grow
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_harvest
      @harvest = Harvest.find(params[:id])

      add_breadcrumb "Harvest"
    end

    # Only allow a list of trusted parameters through.
    def harvest_params
      params.require(:harvest).permit(:grow, :harvested_trim_weight, :harvested_waste_weight, :harvested_bud_weight, :dry_trim_weight, :dry_bud_weight)
    end
end
