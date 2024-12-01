# frozen_string_literal: true

# RoomsController
class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show]

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    #add_breadcrumb @room.name, @room

    @camera = @room.devices.where(device_type: :camera).first
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :room_type, :length, :width, :height, :scenario_id)
  end
end
