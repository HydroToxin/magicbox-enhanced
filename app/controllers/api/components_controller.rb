# frozen_string_literal: true

module Api
  # ComponentsController for the API
  class ComponentsController < ApiController
    before_action :set_component, only: %i[show edit update destroy]

    # GET /components
    # GET /components.json
    def index
      @component = Component.all
    end

    # GET /components/1
    # GET /components/1.json
    def show; end

    # GET /components/new
    def new
      @component = Component.new
    end

    # GET /components/1/edit
    def edit; end

    # POST /components
    # POST /components.json
    def create
      @component = Component.new(component_params)

      respond_to do |format|
        if @component.save
          format.html { redirect_to @component, notice: 'Component was successfully created.' }
          format.json { render :show, status: :created, location: @component }
        else
          format.html { render :new }
          format.json { render json: @component.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /components/1
    # PATCH/PUT /components/1.json
    def update
      respond_to do |format|
        if @components.update(condition_params)
          format.html { redirect_to @component, notice: 'Component was successfully updated.' }
          format.json { render :show, status: :ok, location: @condition }
        else
          format.html { render :edit }
          format.json { render json: @component.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /components/1
    # DELETE /components/1.json
    def destroy
      @component.destroy
      respond_to do |format|
        format.html do
          redirect_to component_url, notice: 'Component was successfully destroyed.'
        end
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_component
      @component = Condition.find(params[:id])
    end

    def components_params
      params.require(:component).permit(:name)
    end
  end
end
