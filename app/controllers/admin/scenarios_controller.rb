# frozen_string_literal: true

module Admin
  # Admin::ScenariosController
  class ScenariosController < Admin::AdminController
    include ApplicationHelper

    before_action :set_scenario, only: %i[show edit update destroy run export]
    before_action :set_room, only: %i[new show edit update destroy]

    # rubocop:disable Metrics/MethodLength
    def new
      @scenario = Scenario.new
    end

    def index
      @scenarios = Scenario.all
    end

    def edit
      @logics = Condition.logics.keys.map { |e| [Condition.logic_text(e.to_sym), e] }
      @condition_types = Condition.condition_types.keys.map { |e| [Condition.condition_type_text(e.to_sym), e] }
      @selected_condidion_type = 'date'
    end

    def create
      @scenario = Scenario.new(scenario_params)
      process_condition_durations(@scenario)

      respond_to do |format|
        if @scenario.save
          format.html do
            redirect_to admin_scenarios_path, notice: 'Scenario was successfully created.'
            format.turbo_stream
          end
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @observation.errors, status: :unprocessable_entity }
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    def update
      process_condition_durations(@scenario)

      binding.pry
      respond_to do |format|
        if @scenario.update(scenario_params)
          format.html { redirect_to admin_scenarios_path, notice: 'Scenario was successfully updated.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @scenario.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @scenario.destroy
      respond_to do |format|
        format.html { redirect_to admin_scenarios_path, notice: 'Scenario was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def load_condition_type_form
      @scenario = Scenario.find(params[:id])
      @condition_type = params[:type]

      respond_to do |format|
        format.html {
          render partial: "admin/scenarios/condition_forms/#{@condition_type}",
          locals: { f: view_context.form_for(@scenario) },
          layout: false
        }
      end
    end

    private

    def process_condition_durations(_scenario)
      params[:scenario][:condition_groups_attributes]&.each_value do |group|
        group[:conditions_attributes]&.each_value do |condition|
          if Condition.condition_types[condition[:condition_type]] == Condition.condition_types[:time_duration]
            duration_in_minutes = (condition[:time_duration_hours].to_i * 60) + condition[:time_duration_minutes].to_i
            condition[:duration] = duration_in_minutes
          end
        end
      end
    end

    # rubocop:disable Metrics/MethodLength
    def scenario_params
      params.require(:scenario).permit(
        :enabled,
        :name,
        :subject_id,
        :description,
        :json_file,
        condition_groups_attributes: [
          :id,
          :name,
          :scenario_id,
          :enabled,
          :_destroy,
          { conditions_attributes: %i[
              id
              data_type_id
              duration
              time_duration_hours
              time_duration_minutes
              predicate
              target_value
              start_time
              end_time
              condition_type
              logic
              condition_group_id
              _destroy
            ],
            operations_attributes: %i[
              id
              command
              delay
              retries
              duration
              device_type
              description
              condition_group_id
              _destroy
            ] }
        ]
      )
    end
    # rubocop:enable Metrics/MethodLength

    def set_scenario
      @scenario = Scenario.find(params[:id])
    end

    def set_room
      return unless params[:room_id].present?

      @room = Room.find(params[:room_id])
    end
  end
end
