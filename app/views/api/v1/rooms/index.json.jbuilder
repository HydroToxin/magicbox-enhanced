# frozen_string_literal: true

json.array! @rooms, partial: 'api/v1/rooms/room', as: :room
