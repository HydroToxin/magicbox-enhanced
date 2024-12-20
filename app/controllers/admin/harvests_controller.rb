# frozen_string_literal: true

module Admin
  # Admin::HarvestsController
  class HarvestsController < Admin::AdminController
    before_action :set_harvest, only: %i[show edit update destroy]
    before_action :set_grow, only: %i[new create show edit update destroy]

    # GET /harvests/new
    def new
      @harvest = Harvest.new
    end

    # POST /harvests
    # POST /harvests.json
    def create
      @harvest = Harvest.new(harvest_params)

      respond_to do |format|
        if @harvest.save
          format.html { redirect_to admin_grow_harvests_path, notice: 'Harvest was successfully created.' }
          format.json { render :show, status: :created, location: @harvest }
        else
          format.html { render :new }
          format.json { render json: @harvest.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /harvests/1
    # PATCH/PUT /harvests/1.json
    def update
      respond_to do |format|
        if @harvest.update(harvest_params)
          format.html { redirect_to admin_grow_harvests_path, notice: 'Harvest was successfully updated.' }
          format.json { render :show, status: :ok, location: @harvest }
        else
          format.html { render :edit }
          format.json { render json: @harvest.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /harvests/1
    # DELETE /harvests/1.json
    def destroy
      @grow = @harvest.grow
      @harvest.destroy
      respond_to do |format|
        format.html { redirect_to @grow, notice: 'Harvest was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_grow
      @grow = Grow.find(params[:grow_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_harvest
      @harvest = Harvest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def harvest_params
      params.require(:harvest).permit(:grow_id, :harvested_trim_weight, :harvested_waste_weight, :harvested_bud_weight,
                                      :dry_trim_weight, :dry_bud_weight)
    end
  end
end
