# frozen_string_literal: true

module Api
  module V1
    # RoomsController for the API
    class RoomsController < ApiController
      before_action :set_room, only: [:show]

      # GET /rooms
      api :GET, '/v1/rooms', 'Get a list of rooms'
      param :limit, :number, desc: 'Limit number of rooms (default: 100, max: 1000)'
      param :offset, :number, desc: 'Offset of rooms'
      param :sort_direction, %w[asc desc], desc: 'The sort direction key'
      param :sort_column, %w[id created_at updated_at], desc: 'The sort column name'

      def index
        @rooms = Room.all

        @rooms = if params.key?(:sort_direction) && params.key?(:sort_column)
                   @rooms.order("#{params[:sort_column]} #{params[:sort_direction]}")
                 else
                   @rooms.order(created_at: :asc)
                 end

        @rooms = if params.key? :limit
                   @rooms.limit(params[:limit])
                 else
                   @rooms.limit(100)
                 end

        return unless params.key? :offset

        @rooms = @rooms.offset(params[:offset])
      end

      # GET /grows/1
      api :GET, '/v1/rooms/:id', 'Get a room item'
      def show
        render json: @room, include: %i[subjects devices events observations scenario]
      end

      private

      def set_room
        @room = Room.find(params[:id])
      end
    end
  end
end
