# frozen_string_literal: true

module Admin
  # Admin::ConditionGroupsController
  class ConditionGroupsController < Admin::AdminController
    def new
      @condition_group = ConditionGroup.new
    end

    def create
      @condition_group = ConditionGroup.build(condition_group_params)
      if @condition_group.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_condition_groups_url, notice: 'Condition group was successfully created.' }
          format.json { render :show, status: :created, location: @condition_group }
        end
      else
        respond_to do |format|
          format.turbo_stream
          format.html { render :new }
          format.json { render json: @condition_group.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @condition_group = ConditionGroup.find(params[:id])
      @condition_group.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_condition_groups_url }
      end
    end

    private

    def condition_group_params
      params.require(:condition_group).permit(:name, :enabled, :scenario_id)
    end
  end
end
