# frozen_string_literal: true

module Api
  module V1
    # PushDevicesController for the API
    class PushDevicesController < ActionController::API
      before_action :set_user

      def create
        PushDevice.create(user_id: @user.id, device_id: push_device_params[:device_id])
        render json: @user
      end

      private

      def set_user
        @user = User.find(params[:user_id])
      end

      def push_device_params
        params.require(:push_device).permit(:device_id)
      end
    end
  end
end
