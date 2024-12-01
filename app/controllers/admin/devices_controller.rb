# frozen_string_literal: true

module Admin
  # Admin::DevicesController
  class DevicesController < Admin::AdminController
    before_action :set_device, only: %i[show edit update destroy start stop query]
    before_action :set_room

    def index
      #add_breadcrumb 'Devices'

      @devices = Device.all

      @devices = if params.key?(:sort_direction) && params.key?(:sort_column)
                   @devices.order("#{params[:sort_column]} #{params[:sort_direction]}")
                 else
                   @devices.order(created_at: :asc)
                 end

      @devices = if params.key? :limit
                   @devices.limit(params[:limit])
                 else
                   @devices.limit(100)
                 end

      return unless params.key? :offset

      @devices = @devices.offset(params[:offset])
    end

    def show; end

    def new
      @device = Device.new
    end

    def edit; end

    # POST /devices
    def create
      @device = Device.new(device_params)

      if @device.save
        redirect_to admin_device_path(@device), notice: 'Device created with success.'
      else
        render :new
      end
    end

    # PATCH/PUT /devices/1
    def update
      if @device.update(device_params)
        redirect_to admin_devices_path, notice: 'Device updated with success.'
      else
        render :edit
      end
    end

    def destroy
      @device.destroy
      redirect_to admin_devices_path, notice: 'Device deleted with success.'
    end

    def start
      result = @device.start

      if result == true
        redirect_back fallback_location: admin_device_path(@device), notice: 'Device started'
      else
        redirect_back fallback_location: admin_device_path(@device), alert: "Device error: #{result}"
      end
    end

    def stop
      result = @device.stop

      if result == true
        redirect_back fallback_location: admin_device_path(@device), notice: 'Device stopped'
      else
        redirect_back fallback_location: admin_device_path(@device), alert: "Device error: #{result}"
      end
    end

    def query
      return if @device.script.nil?

      script = @device.script
      script.query

    end

    private

    def set_device
      @device = Device.find(params[:id])

      #add_breadcrumb @device.name, [:admin, @room, @device]
    end

    def set_room
      return unless params[:room_id].present?

      @room = Room.find(params[:room_id])
    end

    def device_params
      params.require(:device).permit(:device_type, :device_state, :default_duration,
                                     :name, :product_reference, :description, :last_start_date, :use_duration,
                                     :custom_identifier, :product_type, :room_id, :component_id, :device_script_id,
                                     devices_data_types_attributes: [:id, :device_id, :data_type_id, :unit, :_destroy])
    end
  end
end
