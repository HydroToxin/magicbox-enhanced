# frozen_string_literal: true

json.array! @data_types, partial: 'data_types/data_type', as: :data_type
