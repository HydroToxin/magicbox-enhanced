# frozen_string_literal: true

# Scenario
class Scenario < ApplicationRecord
  attr_accessor :json_file

  belongs_to :subject, optional: true
  has_many :room_scenarios, dependent: :destroy
  has_many :rooms, through: :room_scenarios

  validates :name, presence: true

  has_many :condition_groups, dependent: :destroy
  has_many :conditions, through: :condition_groups
  has_many :operations, through: :condition_groups

  accepts_nested_attributes_for :condition_groups, allow_destroy: true, reject_if: :all_blank

  def as_json(*args)
    super.tap do |hash|
      # Ensure condition_groups is initialized as an array if nil
      hash['condition_groups'] ||= []

      hash['condition_groups'].each do |groups|
        groups.tap do |h|
          h['conditions_attributes'] = h.delete('conditions')
          h['operations_attributes'] = h.delete('operations')
        end
      end

      # Rename condition_groups to condition_groups_attributes
      hash['condition_groups_attributes'] = hash.delete('condition_groups')
    end
  end

  # rubocop:disable Metrics/MethodLength
  def run(room)
    return MB_LOGGER.info "Scenario #{name} skipped: disabled" unless enabled

    condition_groups.where(enabled: true).each do |group|
      MB_LOGGER.tagged("Scenario-#{id}") { MB_LOGGER.info "Checking condition group #{group.name}..." }

      all_conditions_met = group.conditions.all? do |condition|
        MB_LOGGER.tagged("Scenario-#{id}") { MB_LOGGER.info 'Evaluating condition...' }
        condition.check_condition(room)
      end

      if all_conditions_met
        MB_LOGGER.tagged("Scenario-#{id}") { MB_LOGGER.info 'All conditions met, executing operations...' }
        group.operations.each do |operation|
          sleep 2
          operation.execute_operation(room)
        end
      else
        MB_LOGGER.tagged("Scenario-#{id}") { MB_LOGGER.info 'Conditions not met' }
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  def self.run_scenarios
    MB_LOGGER.info '########################'
    MB_LOGGER.info '#  Run scenarios (v2)  #'

    Room.all.each do |room|
      room.scenarios.where(enabled: true).each do |scenario|
        MB_LOGGER.tagged("Scenario-#{scenario.id}") do
          MB_LOGGER.info "-> #{room.name} : #{scenario.name} [#{scenario.conditions.count} conditions]"
        end

        scenario.run(room)
      end
    end

    MB_LOGGER.info '########################'
  end

  def self.import(file_path, name)
    json_data = File.read(file_path)
    json = JSON.parse(json_data)

    scenario = Scenario.new(json)
    scenario.name = name

    scenario.save!
    scenario
  end
end
