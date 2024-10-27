# frozen_string_literal: true

module Admin
  # Admin::ConditionsController
  class ConditionsController < Admin::AdminController
    def new
      @condition = Condition.new
    end

    def create
      @condition = Condition.build(condition_params)

      if @condition.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_conditions_url, notice: 'Condition was successfully created.' }
          format.json { render :show, status: :created, location: @condition }
        end
      else
        respond_to do |format|
          format.turbo_stream
          format.html { render :new }
          format.json { render json: @condition.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @condition = Condition.find(params[:id])
      @condition.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_conditions_url }
      end
    end

    private

    def condition_params
      params.require(:condition).permit(:logic, :condition_type, :start_time, :end_time, :time_duration_hours,
                                        :time_duration_minutes, :data_type_id, :predicate, :target_value,
                                        :condition_group_id)
    end
  end
end
