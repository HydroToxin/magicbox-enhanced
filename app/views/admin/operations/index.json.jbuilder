# frozen_string_literal: true

json.array! @operations, partial: 'operations/operation', as: :operation
