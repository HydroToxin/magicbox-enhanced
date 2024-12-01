# frozen_string_literal: true

# HarvestsController
class HarvestsController < ApplicationController
  #before_action :set_grow, only: [:index]
  #before_action :set_harvest, only: [:index]

  def index
    #add_breadcrumb 'Harvest'
    @harvests = Harvest.all
  end

  private

  def set_grow
    @grow = Grow.find(params[:grow_id])

    #add_breadcrumb "Grow ##{@grow.id}"
  end

  def set_harvest
    @harvest = Harvest.find(params[:id])

    #add_breadcrumb 'Harvest'
  end

  # Only allow a list of trusted parameters through.
  def harvest_params
    params.require(:harvest).permit(:grow, :harvested_trim_weight, :harvested_waste_weight, :harvested_bud_weight,
                                    :dry_trim_weight, :dry_bud_weight)
  end
end
