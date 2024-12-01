# frozen_string_literal: true

# Devices Controller
class DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: %i[index show query]
  before_action :set_device, only: %i[show query]

  def index; end

  def show
    @samples = @device.samples.limit(100)
    @values = @samples.where(data_type: DataType.where(name: 'temperature').first).order(created_at: :desc).map do |e|
      [e.created_at, e.value]
    end
  end

  def query
    status = @device.query_sensor
    return redirect_to room_path(@room), notice: 'Query device succeeded.' if status

    redirect_to room_path(@room), alert: 'Query device failed.'
  end

  private

  def set_room
    return unless params[:room_id].present?

    @room = Room.find(params[:room_id])
    #add_breadcrumb @room.name, @room
  end

  def set_device
    @device = Device.find(params[:id])

    #add_breadcrumb @device.name, [@room, @device]
  end

  def device_params
    params.require(:device).permit(:room_id, :device_type, :device_state, :default_duration,
                                   :name, :product_reference, :description, :last_start_date, :use_duration,
                                   :custom_identifier, :product_type, :component, :device_script)
  end
end
