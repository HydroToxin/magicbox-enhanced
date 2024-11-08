# frozen_string_literal: true

module Admin
  # Admin::ConditionsController
  class ConditionsController < Admin::AdminController
    before_action :load_data, only: %i[new edit create update]
    def new
      @condition = Condition.new
    end

    def update
      @turbo_frame_id = params[:turbo_frame_id]
      @selected_option = params[:selected_option]
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
      @condition.destroy if @condition
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_conditions_url }
      end
    end

    def condition_type
      @selected_condidion_type = params[:condition_type]
      respond_to do |format|
        format.turbo_stream
      end
    end

    private

    def load_data
      @condition_types = Condition.condition_types.keys.map { |e| [Condition.condition_type_text(e.to_sym), e] }
      @logics = Condition.logics.keys.map { |e| [Condition.logic_text(e.to_sym), e] }
    end
    def condition_params
      params.require(:condition).permit(:logic, :condition_type, :start_time, :end_time, :time_duration_hours,
                                        :time_duration_minutes, :data_type_id, :predicate, :target_value,
                                        :condition_group_id)
    end
  end
end
