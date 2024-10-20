# frozen_string_literal: true

class SamplesController < ApplicationController
  include SamplesHelper
  before_action :authenticate_user!

  add_breadcrumb 'Statistics'

  def index; end

  def general
    @data_types_samples = {}

    @date_filter = 'today'
    @date_filter = params[:date_filter] if params[:date_filter]

    Sample.unscoped.distinct.where.not(product_reference: 'dht22').pluck(:product_reference).each do |product_reference|
      data = DataType.all.map do |data_type|
        samples = data_type.samples
        now = Time.zone.now

        case @date_filter.to_s
        when 'today'
          samples = samples.where('samples.created_at': now.beginning_of_day..now.end_of_day)
        when 'last_week'
          samples = samples.where('samples.created_at': (now - 7.days)..now.end_of_day)
        when 'last_month'
          samples = samples.where('samples.created_at': (now - 1.month)..now.end_of_day)
        when 'last_year'
          samples = samples.where('samples.created_at': (now - 12.month)..now.end_of_day)
        when 'all_time'
          samples = samples
        else
          puts 'else'
          samples = samples.where('samples.created_at': now.beginning_of_day..now.end_of_day)
        end

        samples = samples.where(product_reference:).order(created_at: :desc)
        next unless samples.first

        {
          name: data_type.name,
          data: samples.map do |e|
            [fdatetime(e.created_at), e.value]
          end,
          color: samples.first.html_color
        }
      end.compact

      @data_types_samples[product_reference] = data
    end
  end

  def rooms
    @data_types_samples = {}

    @date_filter = 'today'
    @date_filter = params[:date_filter] if params[:date_filter]
    puts "date_filter = #{@date_filter}"

    Room.all.each do |room|
      data = DataType.all.map do |data_type|
        samples = room.samples.where(data_type_id: data_type.id)
        now = Time.zone.now

        case @date_filter.to_s
        when 'today'
          samples = samples.where('samples.created_at': now.beginning_of_day..now.end_of_day)
        when 'last_week'
          samples = samples.where('samples.created_at': (now - 7.days)..now.end_of_day)
        when 'last_month'
          samples = samples.where('samples.created_at': (now - 1.month)..now.end_of_day)
        when 'last_year'
          samples = samples.where('samples.created_at': (now - 12.month)..now.end_of_day)
        when 'all_time'
          samples = samples
        else
          puts 'else'
          samples = samples.where('samples.created_at': now.beginning_of_day..now.end_of_day)
        end

        samples = samples.order(created_at: :desc)
        puts "DataType = #{data_type.name}"
        next unless samples.present?

        {
          name: data_type.name,
          data: samples.map { |e| [e.created_at, e.value] },
          color: samples.first.html_color
        }
      end.compact
      @data_types_samples[room.name] = data
    end
  end

  def harvest
    @data_types_samples = {}

    @date_filter = 'today'
    @date_filter = params[:date_filter] if params[:date_filter]

    @data_types_samples = %i[harvested_trim_weight harvested_waste_weight harvested_bud_weight dry_bud_weight
                             dry_trim_weight].map do |k|
      { name: k.to_s.humanize,
        data: Harvest.joins(:grow).order('harvests.created_at ASC').group('harvests.created_at',
                                                                          'grows.description').sum(k) }
    end
  end
end
