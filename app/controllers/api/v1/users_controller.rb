# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      def index
        if params.key? :email
          @user = User.where(email: params[:email]).first

          render json: [@user] and return if @user
        end

        head :no_content
      end
    end
  end
end
