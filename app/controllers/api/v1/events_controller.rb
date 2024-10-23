# frozen_string_literal: true

module Api
  module V1
    # EventsController for the API
    class EventsController < ApiController
      def index
        @events = Event.all

        @events = if params.key? :limit
                    @events.limit(params[:limit])
                  else
                    @events.limit(100)
                  end

        @events = @events.offset(params[:offset]) if params.key? :offset

        render json: @events, include: %i[room device]
      end
    end
  end
end
