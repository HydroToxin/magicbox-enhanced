# frozen_string_literal: true

module Admin
  # Admin::BatchesController
  class BatchesController < Admin::AdminController
    before_action :set_batch, only: %i[show edit update destroy]

    def index; end
    def show; end

    # GET /batches/new
    def new
      #add_breadcrumb 'New Batch'
      @batch = Batch.new
    end

    # GET /batches/1/edit
    def edit; end

    # POST /batches
    # POST /batches.json
    def create
      @batch = Batch.new(batch_params)

      respond_to do |format|
        if @batch.save
          format.html { redirect_to [@batch.grow, @batch.harvest], notice: 'Batch was successfully created.' }
          format.json { render :show, status: :created, location: @batch }
        else
          format.html { render :new }
          format.json { render json: @batch.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /batches/1
    # PATCH/PUT /batches/1.json
    def update
      respond_to do |format|
        if @batch.update(batch_params)
          format.html { redirect_to [@batch.grow, @batch.harvest], notice: 'Batch was successfully updated.' }
          format.json { render :show, status: :ok, location: @batch }
        else
          format.html { render :edit }
          format.json { render json: @batch.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /batches/1
    # DELETE /batches/1.json
    def destroy
      @batch.destroy
      respond_to do |format|
        format.html { redirect_to [@batch.grow, @batch.harvest], notice: 'Batch was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_batch
      @batch = Batch.find(params[:id])
    end

    def batch_params
      params.require(:batch).permit(
        :grow_id,
        :batch_type,
        :harvest_id,
        :name,
        :total_weight,
        :batch_weight,
        :batch_count,
        :price_per_weight,
        :batch_price
      )
    end
  end
end
