class Admin::ConditionsController < ApplicationController
  def new
    @condition_group = ConditionGroup.find(params[:condition_group_id])
    @condition = Condition.new
  end

  def create
    @condition_group = ConditionGroup.find(params[:condition_group_id])
    @condition = @condition_group.conditions.build(condition_params)
    if @condition.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_scenario_path(@condition_group.scenario) }
      end
    else
      render :new
    end
  end

  def destroy
    @condition = Condition.find(params[:id])
    @condition.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to admin_scenario_path(@condition.condition_group.scenario) }
    end
  end

  private

  def condition_params
    params.require(:condition).permit(:logic, :condition_type, :start_time, :end_time, :time_duration_hours, :time_duration_minutes, :data_type_id, :predicate, :target_value)
  end
end
