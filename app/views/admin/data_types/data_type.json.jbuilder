# frozen_string_literal: true

json.extract! data_type, :id, :name, :created_at, :updated_at
json.url data_type_url(data_type, format: :json)
