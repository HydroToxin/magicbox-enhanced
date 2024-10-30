# frozen_string_literal: true

module Api
  module V1
    # SubjectsController for the API
    class SubjectsController < ApiController
      before_action :set_subject, only: %i[show edit update destroy]

      resource_description do
        short 'Subjects'
        description 'Subjects are blavlavla'
        meta 'Subjects' => %w[id name created_at updated_at]
        formats ['json']
        deprecated false
      end

      def_param_group :subject do
        param :subject, Hash do
          param :name, String, desc: 'The name of the subject', required: true
          param :created_at, DateTime, desc: 'The creation date', required: false
          param :created_at, DateTime, desc: 'The update date', required: false
        end
      end

      # GET /subjects
      api :GET, '/v1/subjects', 'Get a list of subjects'
      param :limit, :number, desc: 'Limit number of items (default: 100, max: 1000)'
      param :offset, :number, desc: 'Offset of items'
      param :sort_direction, %w[asc desc], desc: 'The sort direction key'
      param :sort_column, %w[id name created_at updated_at], desc: 'The sort column name'
      def index
        if params.key? :grow_id
          @items = Grow.find(params[:grow_id]).subjects
        else
          @items = Subject.all
        end

        @items = if params.key?(:sort_direction) && params.key?(:sort_column)
                   @items.order("#{params[:sort_column]} #{params[:sort_direction]}")
                 else
                   @items.order(created_at: :asc)
                 end

        @items = if params.key? :limit
                   @items.limit(params[:limit])
                 else
                   @items.limit(100)
                 end

        @items = @items.offset(params[:offset]) if params.key? :offset

        render json: @items, methods: [:strain_name], include: [:grow, :room, { scenarios: {} }]
      end

      # GET /subjects/1
      api :GET, '/v1/subjects/:id', 'Get a subject item'
      def show
        render json: @subject, methods: [:strain_name], include: [:grow, :room, { scenarios: {} }]
      end

      # POST /subjects
      api :POST, '/v1/subjects', 'Create a new subject'
      param_group :subject
      def create
        @subject = Subject.new(subject_params)

        respond_to do |format|
          if @subject.save
            format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
            format.json { render :show, status: :created, location: @subject }
          else
            format.html { render :new }
            format.json { render json: @subject.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /subjects/1
      api :PATCH, '/v1/subjects/:id', 'Update a subject'
      param_group :subject
      def update
        respond_to do |format|
          if @subject.update(subject_params)
            format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
            format.json { render :show, status: :ok, location: @subject }
          else
            format.html { render :edit }
            format.json { render json: @subject.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /subjects/1
      api :DELETE, '/v1/subjects/:id', 'Delete a subject'
      def destroy
        @subject.destroy
        respond_to do |format|
          format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_subject
        @subject = Subject.find(params[:id])
      end

      def subject_params
        params.require(:subject).permit(:name)
      end
    end
  end
end
