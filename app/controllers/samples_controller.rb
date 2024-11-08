# frozen_string_literal: true

# Samples Controller
# ToDo: Refactor Me
class SamplesController < ApplicationController
  include SamplesHelper
  before_action :authenticate_user!
  before_action :date_filter

  add_breadcrumb 'Statistics'

  def index; end

  def general
    @data_types_samples = {}

    Sample.select(:product_reference).all.pluck(:product_reference).uniq.each do |product_reference|
      data = DataType.all.filter_map do |data_type|
        samples = filtered_samples(data_type.samples).where(product_reference:).order(created_at: :desc)
        next unless samples.first

        {
          name: data_type.name,
          data: samples.map { |e| [fdatetime(e.created_at), e.value] },
          color: samples.first.html_color
        }
      end.compact

      @data_types_samples[product_reference] = data
    end
  end

  def rooms
    @data_types_samples = {}

    Room.all.each do |room|
      data_types_samples = DataType.all.filter_map do |data_type|
        samples = filtered_samples(room.samples.where(data_type_id: data_type.id))
        next unless samples.first

        {
          name: data_type.name,
          data: samples.map { |e| [fdatetime(e.created_at, e.value)] },
          color: samples.first.html_color
        }
      end.compact

      @data_types_samples[room.name] = data_types_samples
    end
  end

  def harvest
    @data_types_samples = {}
    @data_types_samples = %i[
      harvested_trim_weight harvested_waste_weight harvested_bud_weight dry_bud_weight
      dry_trim_weight
    ].map do |k|
      {
        name: k.to_s.humanize,
        data: Harvest.joins(:grow).order(
          'harvests.created_at ASC'
        ).group('harvests.created_at', 'grows.description').sum(k)
      }
    end
  end

  private

  def date_filter
    @date_filter = sample_params && sample_params[:date_filter].present? ? sample_params[:date_filter] : 'today'
  end

  def filtered_samples(samples)
    case @date_filter.to_s
    when 'today'
      today(samples)
    when 'last_week'
      last_week(samples)
    when 'last_month'
      last_month(samples)
    when 'last_year'
      last_year(samples)
    end

    samples.order(created_at: :desc)
  end

  def today(samples)
    now = Time.zone.now
    samples.where('samples.created_at': (now - 7.days)..now.end_of_day)
  end

  def last_week(samples)
    now = Time.zone.now
    samples.where('samples.created_at': (now - 7.days)..now.end_of_day)
  end

  def last_month(samples)
    now = Time.zone.now
    samples.where('samples.created_at': (now - 7.days)..now.end_of_day)
  end

  def last_year(samples)
    now = Time.zone.now
    samples.where('samples.created_at': (now - 12.month)..now.end_of_day)
  end

  def sample_params
    return if params[:sample].nil?
    params.require(:sample).permit(:product_reference, :data_type_id, :value, :unit, :date_filter)
  end
end
