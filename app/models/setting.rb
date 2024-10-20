# RailsSettings Model
class Setting < RailsSettings::Base
  cache_prefix { "v1" }

  field :app_hostname,                  type: :stirng, default: "http://locahlhost"
  field :app_email,                     type: :string, default: "no-reply@magicbox.example.org"
  field :openweather_city, 							type: :string, default: "Narbonne"
  field :openweather_endpoint, 					type: :string, default: "http://api.openweathermap.org/data/2.5/weather"
  field :time_zone, 										type: :string, default: "Europe/Paris"
  field :tempodominus_date_format, 			default: "DD.MM.YYYY", type: :string
  field :tempodominus_time_format, 			default: "hh:mm", type: :string
  field :rails_date_format, 						default: "%d.%m.%Y", type: :string
  field :rails_time_format, 						default: "%H:%M", type: :string
  field :calendar_default_view, 				type: :string, default: "month"
  field :calendar_weeks_enabled, 				type: :boolean, default: true
  field :calendar_todos_enabled, 				type: :boolean, default: true
  field :calendar_issues_enabled, 			type: :boolean, default: true
  field :calendar_observations_enabled,	type: :boolean, default: true
  field :units_weight,                  type: :string, default: "g"
  field :units_currency,                type: :string, default: "€"
end
