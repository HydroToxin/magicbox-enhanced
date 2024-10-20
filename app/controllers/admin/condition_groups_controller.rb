# frozen_string_literal: true

module Admin
  class ConditionGroupsController < ApplicationController
    def new
      @condition_group = ConditionGroup.new

      respond_to do |format|
        format.html # falls du eine volle Seitenantwort benötigst
        format.turbo_stream # Bereite Turbo Stream Antwort vor
      end
    end

    def create
      @scenario = Scenario.find(params[:scenario_id])
      @condition_group = @scenario.condition_groups.build(condition_group_params)
      if @condition_group.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_scenario_path(@scenario) } # Fallback
        end
      else
        render :new
      end
    end

    def destroy
      @condition_group = ConditionGroup.find(params[:id])
      @condition_group.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_scenario_path(@condition_group.scenario) }
      end
    end

    private

    def condition_group_params
      params.require(:condition_group).permit(:name, :enabled)
    end
  end
end
