# frozen_string_literal: true

json.array! @harvests, partial: 'harvests/harvest', as: :harvest
