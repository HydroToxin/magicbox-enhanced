# frozen_string_literal: true

module Admin
  # Admin::ComponentsController
  class ComponentsController < Admin::AdminController
    before_action :set_component, only: %i[show edit update destroy]

    def index
      @components = Component.all
      respond_to do |format|
        format.html { render :index }
        format.json { render json: Component.all.to_json}
      end
    end

    def new
      @component = Component.new
    end

    def show
      @component = Component.find(params[:id])
      return unless @component

      respond_to do |format|
        format.html { render :index }
        format.json { render json: @component.as_json(include: :control_pins) }
      end
    end

    def create
      @component = Component.new(component_params)

      respond_to do |format|
        if @component.save
          format.html do
            redirect_to admin_components_path, notice: 'Component was successfully created.'
            format.turbo_stream
          end
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @component.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @component.update(component_params)
          format.html { redirect_to admin_components_path, notice: 'Component was successfully updated.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @component.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @component.destroy
      respond_to do |format|
        format.html { redirect_to admin_components_path, notice: 'Component was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def component_params
      params.require(:component).permit(
        :name,
        :component_type,
        :model,
        :version,
        :active,
        :microcontroller,
        :multiplexer,
        :address,
        :voltage,
        :power,
        :standby_ampere,
        :max_ampere,
        :watt,
        :temperature,
        :description,
        :image,
        control_pins_attributes: [
          :id,
          :name,
          :pin_number,
          :left,
          :right,
          :pin_function,
          :com_number,
          :signal_type,
          :signal_mode,
          :pull_resistor,
          :initial_state,
          :voltage,
          :description,
          :_destroy
        ]
      )
    end

    def set_component
      @component = Component.find(params[:id])
    end

  end
end
