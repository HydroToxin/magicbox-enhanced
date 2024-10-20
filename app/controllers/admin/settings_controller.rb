module Admin
  class SettingsController < ApplicationController
  	add_breadcrumb 'Settings'

    def show
      respond_to do |format|
        format.html   # Falls Sie auch reguläre HTML-Anfragen unterstützen
      end
    end
    def create
      setting_params.keys.each do |key|
        Setting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
      end
      redirect_to admin_settings_path, notice: "Settings were successfully updated."
    end

    private
      def setting_params
        params.require(:setting).permit(
          :app_email,
          :app_hostname,
        	:openweather_city,
					:openweather_endpoint,
					:time_zone,
					:date_format,
					:time_format,
					:rails_date_format,
					:rails_time_format,
					:calendar_default_view,
          :calendar_weeks_enabled,
          :calendar_todos_enabled,
          :calendar_issues_enabled,
          :calendar_observations_enabled,
          :units_weight,
          :units_currency
        )
      end
  end
end