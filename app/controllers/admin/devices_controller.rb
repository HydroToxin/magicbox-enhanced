# frozen_string_literal: true

module Admin
  # Admin::DevicesController
  class DevicesController < Admin::AdminController
    before_action :set_room, only: %i[new show edit create update destroy start stop samples query]
    before_action :set_device, only: %i[show edit update destroy start stop query]

    def index
      add_breadcrumb 'Devices'

      @devices = @room ? @room.devices : Device.all

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
        redirect_to room_device_path(@device.room, @device), notice: 'Device created with success.'
      else
        render :new
      end
    end

    # PATCH/PUT /devices/1
    def update
      if @device.update(device_params)
        redirect_to room_device_path(@device.room, @device), notice: 'Device updated with success.'
      else
        render :edit
      end
    end

    def destroy
      @device.destroy
      redirect_to room_path(@room), notice: 'Device deleted with success.'
    end

    def start
      result = @device.start

      if result == true
        redirect_back fallback_location: room_path(@room), notice: 'Device started'
      else
        redirect_back fallback_location: room_path(@room), alert: "Device error: #{result}"
      end
    end

    def stop
      result = @device.stop

      if result == true
        redirect_back fallback_location: room_path(@room), notice: 'Device stopped'
      else
        redirect_back fallback_location: room_path(@room), alert: "Device error: #{result}"
      end
    end

    private

    def samples
      @devices = @room.devices
    end

    def set_room
      return unless params[:room_id].present?

      @room = Room.find(params[:room_id])

      add_breadcrumb @room.name, [:admin, @room]
    end

    def set_device
      @device = Device.find(params[:id])

      add_breadcrumb @device.name, [:admin, @room, @device]
    end

    def device_params
      params.require(:device).permit(:room_id, :device_type, :device_state, :pin_number, :pin_type, :default_duration,
                                     :name, :product_reference, :description, :last_start_date, :use_duration,
                                     :watts, :volts, :amperes, :custom_identifier, :product_type)
    end
  end
end
