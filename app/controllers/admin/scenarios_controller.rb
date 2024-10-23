# frozen_string_literal: true

module Admin
  # Admin::ScenariosController
  class ScenariosController < Admin::AdminController
    before_action :authenticate_user!
    before_action :set_scenario, only: %i[show edit update destroy run export]

    # rubocop:disable Metrics/MethodLength
    def new
      @scenario = Scenario.new
      @condition_group = @scenario.condition_groups.build
    end

    def create
      @scenario = Scenario.new(scenario_params)
      process_condition_durations(@scenario)

      respond_to do |format|
        if @scenario.save
          format.html do
            redirect_to admin_scenario_path(@scenario), notice: 'Scenario was successfully created.'
          end
          format.turbo_stream
        else
          format.html { render :new }
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(dom_id(@scenario, :form), partial: 'scenarios/form',
                                                                                locals: { scenario: @scenario })
          end
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    def update
      process_condition_durations(@scenario)

      respond_to do |format|
        if @scenario.update(scenario_params)
          format.html do
            redirect_to admin_scenario_path(@scenario), notice: 'Scenario was successfully updated.'
          end
          format.turbo_stream
        else
          format.html { render :edit }
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(dom_id(@scenario, :form), partial: 'scenarios/form',
                                                                                locals: { scenario: @scenario })
          end
        end
      end
    end

    def destroy
      @scenario.destroy
      respond_to do |format|
        format.html do
          redirect_to admin_scenarios_url, notice: 'Scenario was successfully destroyed.'
        end
        format.turbo_stream { head :no_content }
      end
    end

    def run; end

    def export; end

    private

    def process_condition_durations(_scenario)
      # Logik zur Umwandlung der Arbeitszeiten aus bedingten Zeitfeldern in Timestamps
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
  end
end
