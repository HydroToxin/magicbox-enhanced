# frozen_string_literal: true

module Api
  module V1
    class ScenariosController < ApiController
      before_action :set_scenario, only: %i[show edit update destroy]

      respond_to :json

      resource_description do
        short 'Scenarios '
        description 'Scenarios are used to automate operations based on a multiple conditions system.'
        meta 'Scenario' => %w[id name subject_id created_at updated_at]
        formats ['json']
        deprecated false
      end

      def_param_group :scenario do
        param :scenario, Hash do
          param :name, String, desc: 'The name of the scenario', required: true
          param :subject_id, :number, desc: 'The subject ID of the scenario', required: true
          param :description, String, desc: 'The description of the scenario', required: true
          param :created_at, DateTime, desc: 'The creation date', required: false
          param :created_at, DateTime, desc: 'The update date', required: false
        end
      end

      # GET /scenarios
      api :GET, '/v1/scenarios', 'Get a list of scenarios'
      param :limit, :number, desc: 'Limit number of items (default: 100, max: 1000)'
      param :offset, :number, desc: 'Offset of items'
      param :sort_direction, %w[asc desc], desc: 'The sort direction key'
      param :sort_column,
            %w[id device_type device_state name pin_number pin_type product_reference description last_start_date created_at updated_at], desc: 'The sort column name'
      def index
        @items = Scenario.all

        @items = if params.key?(:sort_direction) && params.key?(:sort_column)
                   @items.order("#{params[:sort_column]} #{params[:sort_direction]}")
                 else
                   @items.order(created_at: :asc)
                 end

        @items = if params.key? :limit
                   @items.limit(params[:limit])
                 else
                   @items.limit(100)
                 end

        @items = @items.offset(params[:offset]) if params.key? :offset

        render json: @items, include: { conditions: { include: :operations }, subject: {} }
      end

      # GET /scenarios/1
      api :GET, '/v1/scenarios/:id', 'Get a scenario item'
      def show
        render json: @scenario, include: { conditions: { include: :operations }, subject: {} }
      end

      # POST /scenarios
      api :POST, '/v1/scenarios', 'Create a new scenario'
      param_group :scenario
      def create
        @scenario = Scenario.new(scenario_params)

        respond_to do |_format|
          if @scenario.save
            render :show, status: :created, location: @scenario
          else
            render json: @scenario.errors, status: :unprocessable_entity
          end
        end
      end

      # PATCH/PUT /scenarios/1
      api :PATCH, '/v1/scenarios/:id', 'Update a scenario'
      param_group :scenario
      def update
        respond_to do |_format|
          if @scenario.update(scenario_params)
            render :show, status: :ok, location: @scenario
          else
            render json: @scenario.errors, status: :unprocessable_entity
          end
        end
      end

      # DELETE /scenarios/1
      api :DELETE, '/v1/scenarios/:id', 'Delete a scenario'
      def destroy
        @scenario.destroy
        head :no_content
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_scenario
        @scenario = Scenario.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def scenario_params
        params.require(:scenario).permit(
          :name,
          :subject_id,
          :description,
          conditions_attributes: %i[
            id
            name
            data_type_id
            predicate
            target_value
            start_time
            end_time
            scenario_id
            _destroy
          ]
        )
      end
    end
  end
end
