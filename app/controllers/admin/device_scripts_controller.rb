# frozen_string_literal: true

# DeviceScripts Controller
module Admin
  class DeviceScriptsController < ApplicationController
    before_action :set_device_script, only: %i[show edit update destroy]

    def show; end

    def new
      @device_script = DeviceScript.new
    end

    def create
      @device_script = DeviceScript.new(device_script_params)
      respond_to do |format|
        if @device_script.save
          format.html do
            redirect_to admin_device_scripts_path, notice: 'device_script was successfully created.'
          end
          format.json { render :show, status: :created, location: @device_script }
        else
          format.html { render :new }
          format.json { render json: @device_script.errors, status: :unprocessable_entity }
        end
      end
    end

    def index
      @device_scripts = DeviceScript.all
      respond_to do |format|
        format.html
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @device_script.update(device_script_params)
          format.html do
            redirect_to admin_device_scripts_path, notice: 'DeviceScript was successfully updated.'
          end
          format.json { render :show, status: :ok, location: @device_script }
        else
          format.html { render :edit }
          format.json { render json: @device_script.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @device_script.destroy
      respond_to do |format|
        format.html { redirect_to admin_device_scripts_path, notice: 'Device Script was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def device_script_params
      params.require(:device_script).permit(:name, :script_name, :description)
    end

    def set_device_script
      @device_script = DeviceScript.find(params[:id])
    end
  end
end
