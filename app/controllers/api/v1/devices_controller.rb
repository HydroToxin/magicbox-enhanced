# frozen_string_literal: true

module Api
  module V1
    # DevicesController for the API
    class DevicesController < ApiController
      before_action :set_device, only: %i[show update destroy start stop]

      resource_description do
        short 'Active devices managed by MagixBox'
        description 'Devices regroups all the active modules that
                     can interact with the MagicBox environment such as sensors, fans, pumps, etc.'
        meta 'Device' => %w[id device_type device_state pin_number pin_type name product_reference
                            description last_start_date created_at updated_at]
        formats ['json']
        deprecated false
      end

      # GET /devices
      api :GET, '/v1/devices', 'Get a list of devices'
      param :limit, :number, desc: 'Limit number of devices (default: 100, max: 1000)'
      param :offset, :number, desc: 'Offset of devices'
      param :sort_direction, %w[asc desc], desc: 'The sort direction key'
      param :sort_column,
            %w[id device_type device_state name pin_number pin_type product_reference
               description last_start_date created_at updated_at], desc: 'The sort column name'
      def index
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

        @devices = @devices.offset(params[:offset]) if params.key? :offset

        render json: @devices, include: [:data_types]
      end

      # GET /devices/1
      api :GET, '/v1/devices/:id', 'Get a device item'
      def show
        render json: @device, include: [:data_types]
      end

      # POST /devices
      def create
        @device = Device.new(device_params)

        if @device.save
          render json: @device, status: :created, location: @device
        else
          render json: @device.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /devices/1
      def update
        if @device.update(device_params)
          render json: @device
        else
          render json: @device.errors, status: :unprocessable_entity
        end
      end

      # DELETE /devices/1
      def destroy
        @device.destroy
      end

      api :POST, '/v1/devices/:id/start', 'Start a device'
      def start
        if @device.off?
          # result = `python scripts/arduino.py
          # COMMAND:DIGITAL_WRITE:#{@device.pin_number}:1:#{@device.default_duration}`
          # response = JSON.parse(result)
          # puts response

          # @device.device_state = :on
          # @device.save
          render json: @device
        elsif @device.idle?
          render json: { errors: 'Device is not managable' }
        else
          render json: { errors: 'Device already started' }
        end
      end

      api :POST, '/v1/devices/:id/stop', 'Stop a device'
      def stop
        if @device.on?
          # result = `python scripts/arduino.py
          # COMMAND:DIGITAL_WRITE:#{@device.pin_number}:0:#{@device.default_duration}`
          # puts result

          # @device.device_state = :off
          # @device.save
          render json: @device

        elsif @device.idle?
          render json: { errors: 'Device is not managable' }
        else
          render json: { errors: 'Device already stopped' }
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_device
        @device = Device.find(params[:id])
      end

      def device_params
        params.require(:device).permit(:device_type, :device_state, :pin_number, :default_duration, :pin_type, :name,
                                       :product_reference, :description, :last_start_date)
      end
    end
  end
end
