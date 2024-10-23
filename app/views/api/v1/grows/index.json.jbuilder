# frozen_string_literal: true

json.array! @grows, partial: 'api/v1/grows/grow', as: :grow
