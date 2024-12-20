# frozen_string_literal: true

module Admin
  # Admin::GrowsController
  class GrowsController < Admin::AdminController
    before_action :set_grow, only: %i[edit update destroy]

    # GET /grows/new
    def new
      @grow = Grow.new(birth_type: 'from_seed')

      add_breadcrumb 'Grows', grows_path
      add_breadcrumb 'New'
    end

    # GET /grows/1/edit
    def edit
      add_breadcrumb 'Edit'
    end

    # POST /grows
    # POST /grows.json
    # rubocop:disable Metrics/MethodLength
    def create
      @grow = Grow.new(grow_params)

      respond_to do |format|
        if @grow.save
          # create subjects
          if @grow.birth_type == 'from_clone'
            @grow.number_of_subjects.times do |i|
              room = Room.find(params[:room])
              next unless room

              Subject.create!(
                name: "Subject #{i + 1}",
                grow_id: @grow.id,
                room_id: room.id,
                birth_type: @grow.birth_type,
                strain_id: params[:strain_id],
                mother_id: @grow.mother_id
              )
            end
          end
          @grow.generate_weeks

          format.turbo_stream
          format.html { redirect_to @grow, notice: 'Grow was successfully created.' }
          format.json { render :show, status: :created, location: @grow }
        else
          format.turbo_stream
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @grow.errors, status: :unprocessable_entity }
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    # PATCH/PUT /grows/1
    # PATCH/PUT /grows/1.json
    def update
      respond_to do |format|
        if @grow.update(grow_params)
          @grow.generate_weeks

          format.html { redirect_to @grow, notice: 'Grow was successfully updated.' }
          format.json { render :show, status: :ok, location: @grow }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @grow.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /grows/1
    # DELETE /grows/1.json
    def destroy
      @grow.destroy
      respond_to do |format|
        format.html { redirect_to grows_url, notice: 'Grow was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_grow
      @grow = Grow.find(params[:id])

      add_breadcrumb "Grow ##{@grow.id}"
    end

    # rubocop:disable Metrics/MethodLength
    def grow_params
      params.require(:grow).permit(
        :grow_status,
        :auto_update_status,
        :birth_type,
        :mother_id,
        :strain_id,
        :description,
        :start_date,
        :seedling_weeks,
        :vegging_weeks,
        :flowering_weeks,
        :flushing_weeks,
        :drying_weeks,
        :curing_weeks,
        :substrate,
        :flowering,
        :estimated_weight_by_square_meter,
        :number_of_subjects
      )
    end
    # rubocop:enable Metrics/MethodLength
  end
end
