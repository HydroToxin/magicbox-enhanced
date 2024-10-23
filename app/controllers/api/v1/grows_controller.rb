# frozen_string_literal: true

module Api
  module V1
    # GrowsController for the API
    class GrowsController < ApiController
      before_action :set_grow, only: [:show]

      # GET /grows
      api :GET, '/v1/grows', 'Get a list of grows'
      param :limit, :number, desc: 'Limit number of grows (default: 100, max: 1000)'
      param :offset, :number, desc: 'Offset of grows'
      param :sort_direction, %w[asc desc], desc: 'The sort direction key'
      param :sort_column, %w[id created_at updated_at], desc: 'The sort column name'

      def index
        @grows = Grow.all

        @grows = if params.key?(:sort_direction) && params.key?(:sort_column)
                   @grows.order("#{params[:sort_column]} #{params[:sort_direction]}")
                 else
                   @grows.order(created_at: :asc)
                 end

        @grows = if params.key? :limit
                   @grows.limit(params[:limit])
                 else
                   @grows.limit(100)
                 end

        return unless params.key? :offset

        @grows = @grows.offset(params[:offset])

        # TODO: rewrite using builder to optimize load and avoid includes
        # render json: @grows,
        #   include: [
        #  :observations,
        #     :subjects => {:methods => [:strain_name]},
        #     :weeks => {:methods => [:color]}
        #   ],
        #   methods: [
        #     :progress_percents,
        #     :end_date
        #   ]
      end

      # GET /grows/1
      api :GET, '/v1/grows/:id', 'Get a grow item'
      def show
        render json: @grow, include: %i[subjects weeks observations], methods: %i[progress_percents end_date]
      end

      private

      def set_grow
        @grow = Grow.find(params[:id])
      end
    end
  end
end
