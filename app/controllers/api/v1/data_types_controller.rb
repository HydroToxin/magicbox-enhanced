# frozen_string_literal: true

module Api
  module V1
    # DataTypesController for the API
    class DataTypesController < ApiController
      before_action :set_data_type, only: %i[show update destroy]

      resource_description do
        short 'DataType from devices'
        description 'DataType are used to define the output value returned by a qualified device, like a sensor.'
        meta 'DataType' => %w[id name created_at updated_at]
        formats ['json']
        deprecated false
      end

      # GET /data_types
      api :GET, '/v1/data_types', 'Get a list of data types'
      def index
        @data_types = DataType.all

        render json: @data_types, except: %i[created_at updated_at]
      end

      # GET /data_types/1
      api :GET, '/v1/data_types/:id', 'Get a data types item'
      def show
        render json: @data_type
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_data_type
        @data_type = DataType.find(params[:id])
      end

      def data_type_params
        params.require(:data_type).permit(:name)
      end
    end
  end
end
