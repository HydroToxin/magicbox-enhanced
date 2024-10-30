# frozen_string_literal: true

# ObservationsController
class ObservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_observation, only: %i[show edit update destroy]
  before_action :set_grow, only: %i[new create show edit update destroy]

  # GET /observations
  # GET /observations.json
  def index
    @observations = Observation.all
  end

  # GET /observations/1
  # GET /observations/1.json
  def show; end

  # GET /observations/new
  def new
    add_breadcrumb 'New observation'

    @observation = Observation.new

    return unless current_user.observations.last

    current_user.observations.last.observation_resources.each do |rd|
      @observation.observation_resources.build(
        resource_id: rd.resource_id,
        observation_id: rd.observation_id,
        value: rd.value,
        unit: rd.unit,
        category_id: rd.resource.category_id
      )
    end
  end

  # GET /observations/1/edit
  def edit; end

  # POST /observations
  # POST /observations.json
  def create
    @observation = Observation.new(observation_params)
    @grow = @observation.grow

    respond_to do |format|
      if @observation.save
        message = "New observation has been created by <b>#{current_user.username}</b>"

        Event.create! event_type: :action, message: message, eventable: @observation, user_id: current_user.id

        format.html { redirect_to @grow, notice: 'Observation was successfully created.' }
        format.json { render :show, status: :created, location: @observation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /observations/1
  # PATCH/PUT /observations/1.json
  def update
    respond_to do |format|
      if @observation.update(observation_params)
        format.html do
          redirect_to [@grow, @observation], notice: 'Observation was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @observation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observations/1
  # DELETE /observations/1.json
  def destroy
    @observation.destroy
    respond_to do |format|
      format.html { redirect_to @grow, notice: 'Observation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_observation
    @observation = Observation.find(params[:id])
  end

  def set_grow
    return if params[:grow_id].nil?

    @grow = Grow.find(params[:grow_id])
    add_breadcrumb "Grow ##{@grow.id}", @grow
  end
  # rubocop:disable Metrics/MethodLength
  def observation_params
    params.require(:observation).permit(
      :user_id,
      :grow_id,
      :room_id,
      :subject_id,
      :body,
      :water,
      :nutrients,
      subject_ids: [],
      pictures: [],
      observation_resources_attributes: %i[
        id
        subject_id
        observation_id
        resource_id
        value
        unit
        _destroy
      ],
      issues_attributes: %i[
        id
        subject_id
        observation_id
        resource_id
        issue_type
        issue_status
        severity
        _destroy
      ]
    )
  end
  # rubocop:enable Metrics/MethodLength
end
