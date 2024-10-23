# frozen_string_literal: true

json.array! @observations, partial: 'observations/observation', as: :observation
