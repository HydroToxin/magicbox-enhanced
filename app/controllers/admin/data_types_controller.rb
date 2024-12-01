# frozen_string_literal: true

module Admin
  # Admin::DataTypesController
  class DataTypesController < Admin::AdminController
    before_action :set_data_type, only: %i[show edit update destroy]

    # GET /data_types
    # GET /data_types.json
    def index
      @data_types = DataType.all
    end

    # GET /data_types/1
    # GET /data_types/1.json
    def show; end

    # GET /data_types/new
    def new
      @data_type = DataType.new
    end

    # GET /data_types/1/edit
    def edit; end

    # POST /data_types
    # POST /data_types.json
    def create
      @data_type = DataType.new(data_type_params)

      respond_to do |format|
        if @data_type.save
          format.html do
            redirect_to admin_data_types_path, notice: 'DataType was successfully created.'
          end
          format.json { render :show, status: :created, location: @data_type }
        else
          format.html { render :new }
          format.json { render json: @data_type.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /data_types/1
    # PATCH/PUT /data_types/1.json
    def update
      respond_to do |format|
        if @data_type.update(data_type_params)
          format.html do
            redirect_to admin_data_types_path, notice: 'DataType was successfully updated.'
          end
          format.json { render :show, status: :ok, location: @data_type }
        else
          format.html { render :edit }
          format.json { render json: @data_type.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /data_types/1
    # DELETE /data_types/1.json
    def destroy
      @data_type.destroy
      respond_to do |format|
        format.html do
          redirect_to admin_data_types_path, notice: 'DataType was successfully destroyed.'
        end
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_data_type
      @data_type = DataType.find(params[:id])
    end

    def data_type_params
      params.require(:data_type).permit(:name, :id)
    end
  end
end
