class Admin::ScenariosController < Admin::AdminController
  before_action :authenticate_user!
  before_action :set_scenario, only: [:show, :edit, :update, :destroy, :run, :export]

  def new
    @scenario = Scenario.new
    @condition_group = @scenario.condition_groups.build
  end

  def create
    @scenario = Scenario.new(scenario_params)
    process_condition_durations(@scenario)

    respond_to do |format|
      if @scenario.save
        format.html { redirect_to admin_scenario_path(@scenario), notice: 'Scenario was successfully created.' }
        format.turbo_stream
      else
        format.html { render :new }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@scenario, :form), partial: 'scenarios/form', locals: { scenario: @scenario }) }
      end
    end
  end

  def update
    process_condition_durations(@scenario)

    respond_to do |format|
      if @scenario.update(scenario_params)
        format.html { redirect_to admin_scenario_path(@scenario), notice: 'Scenario was successfully updated.' }
        format.turbo_stream
      else
        format.html { render :edit }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@scenario, :form), partial: 'scenarios/form', locals: { scenario: @scenario }) }
      end
    end
  end

  def destroy
    @scenario.destroy
    respond_to do |format|
      format.html { redirect_to admin_scenarios_url, notice: 'Scenario was successfully destroyed.' }
      format.turbo_stream { head :no_content }
    end
  end

  def run
  end

  def export
  end

  private

  def process_condition_durations(scenario)
    # Logik zur Umwandlung der Arbeitszeiten aus bedingten Zeitfeldern in Timestamps
    params[:scenario][:condition_groups_attributes]&.each do |_, group|
      group[:conditions_attributes]&.each do |_, condition|
        if Condition.condition_types[condition[:condition_type]] == Condition.condition_types[:time_duration]
          duration_in_minutes = (condition[:time_duration_hours].to_i * 60) + condition[:time_duration_minutes].to_i
          condition[:duration] = duration_in_minutes
        end
      end
    end
  end

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
        conditions_attributes: [
          :id,
          :data_type_id,
          :duration,
          :time_duration_hours,
          :time_duration_minutes,
          :predicate,
          :target_value,
          :start_time,
          :end_time,
          :condition_type,
          :logic,
          :condition_group_id,
          :_destroy
        ],
        operations_attributes: [
          :id,
          :command,
          :delay,
          :retries,
          :duration,
          :device_type,
          :description,
          :condition_group_id,
          :_destroy
        ]
      ]
    )
  end

  def set_scenario
    @scenario = Scenario.find(params[:id])
  end
end
