# frozen_string_literal: true

module Admin
  # Admin::CircuitsController
  class CircuitsController < Admin::AdminController
    before_action :set_circuit, only: %i[show edit update destroy]

    def index
      @circuits = Circuit.all
    end

    def new
      @circuit = Circuit.new
    end

    def create
      @circuit = Circuit.new(circuit_params)

      respond_to do |format|
        if @circuit.save
          format.html do
            redirect_to admin_circuits_path, notice: 'Circuit was successfully created.'
            format.turbo_stream
          end
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @circuit.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @circuit.update(circuit_params)
          format.html { redirect_to admin_circuits_path, notice: 'Circuit was successfully updated.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @circuits.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @circuit.destroy
      respond_to do |format|
        format.html { redirect_to admin_circuits_path, notice: 'Circuit was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def circuit_params
      params.require(:circuit).permit(
        :name,
        :active,
        :_destroy,
        {
          component_connections_attributes: [
            :id,
            :source_component_id,
            :target_component_id,
            :_destroy,
            {
              component_pin_connections_attributes: [
                :id,
                :source_control_pin_id,
                :target_control_pin_id,
                :_destroy
              ],
            }
          ]
        }
      )
    end

    def set_circuit
      @circuit = Circuit.find(params[:id])
    end

  end
end