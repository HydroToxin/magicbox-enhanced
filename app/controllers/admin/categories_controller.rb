# frozen_string_literal: true

module Admin
  # Admin::CategoriesController
  class CategoriesController < ApplicationController
    before_action :set_category, only: %i[show edit update destroy]

    def show; end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      respond_to do |format|
        if @category.save
          format.html do
            redirect_to admin_categories_path, notice: 'Category was successfully created.'
          end
          format.json { render :show, status: :created, location: @category }
        else
          format.html { render :new }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end

    def index
      @categories = Category.all
    end

    def edit; end

    def update
      respond_to do |format|
        if @category.update(category_params)
          format.html do
            redirect_to admin_categories_path, notice: 'Category was successfully updated.'
          end
          format.json { render :show, status: :ok, location: @category }
        else
          format.html { render :edit }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @category.destroy
      respond_to do |format|
        format.html do
          redirect_to admin_categories_url, notice: 'Category was successfully destroyed.'
        end
        format.json { head :no_content }
      end
    end

    private

    def category_params
      params.require(:category).permit(:name, :description)
    end

    def set_category
      @category = Category.find(params[:id])
    end
  end
end
