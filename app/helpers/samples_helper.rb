# frozen_string_literal: true

module SamplesHelper
  def build_samples_path(target, filter)
    case target
    when 'rooms'
      rooms_samples_path(date_filter: filter)
    when 'harvest'
      harvest_samples_path(date_filter: filter)
    when 'general'
      general_samples_path(date_filter: filter)
    end
  end
end
