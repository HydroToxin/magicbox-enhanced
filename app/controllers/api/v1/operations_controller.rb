# frozen_string_literal: true

module Api
  module V1
    # OperationsController for the API
    class OperationsController < ApiController
      before_action :set_operation, only: %i[show edit update destroy]

      # GET /operations
      # GET /operations.json
      def index
        @operations = Operation.all
      end

      # GET /operations/1
      # GET /operations/1.json
      def show; end

      # GET /operations/new
      def new
        @operation = Operation.new
      end

      # GET /operations/1/edit
      def edit; end

      # POST /operations
      # POST /operations.json
      def create
        @operation = Operation.new(operation_params)

        respond_to do |format|
          if @operation.save
            format.html { redirect_to @operation, notice: 'Operation was successfully created.' }
            format.json { render :show, status: :created, location: @operation }
          else
            format.html { render :new }
            format.json { render json: @operation.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /operations/1
      # PATCH/PUT /operations/1.json
      def update
        respond_to do |format|
          if @operation.update(operation_params)
            format.html { redirect_to @operation, notice: 'Operation was successfully updated.' }
            format.json { render :show, status: :ok, location: @operation }
          else
            format.html { render :edit }
            format.json { render json: @operation.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /operations/1
      # DELETE /operations/1.json
      def destroy
        @operation.destroy
        respond_to do |format|
          format.html do
            redirect_to operations_url, notice: 'Operation was successfully destroyed.'
          end
          format.json { head :no_content }
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_operation
        @operation = Operation.find(params[:id])
      end

      def operation_params
        params.require(:operation).permit(:command, :delay, :retries, :device_id, :description, :condition_id)
      end
    end
  end
end
