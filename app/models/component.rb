# frozen_string_literal: true

# Component Model
class Component < ApplicationRecord
  has_many :control_pins, dependent: :destroy

  has_many :outgoing_connections,
    class_name: 'ComponentConnection',
    foreign_key: 'source_component_id',
    dependent: :destroy

  has_many :incoming_connections,
    class_name: 'ComponentConnection',
    foreign_key: 'target_component_id',
    dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :component_type, presence: true

  accepts_nested_attributes_for :control_pins,
    allow_destroy: true,
    reject_if: :all_blank

  enum component_type: {
    microcontroller: 'Microcontroller',
    electronic_parts: 'Electronic Parts',
    electronmechanical: 'Electronmechanical',
    sensor: 'Sensor',
    display: 'Display Technology',
    power_electronics: 'Power Electonics',
    power_supply: 'Power Supply',
    multiplexer: 'Multiplexer',
    demultiplexer: 'Demultiplexer',
    consumer: 'Consumer'
  }

  def self.component_type_descriptions
    {
      microcontroller: 'An integrated circuit designed to perform specific tasks, containing a processor, memory, and programmable input/output peripherals',
      electronic_parts: 'Electronic components that do not require external power or to operate and cannot generate or amplify electrical signals',
      electronmechanical: 'Components that combine electrical and mechanical systems to perform various functions',
      sensor: 'Devices that detect and measure physical properties, converting them into electrical signals',
      displays: 'Methods and technologies for visualizing information through electronic displays',
      power_electronics: 'Electronic systems and components used for switching, converting, and controlling electrical power',
      power_supply: 'Devices or systems that provide electrical energy to other electronic components',
      multiplexer: 'A device that selects one of several input signals and forwards it to a single output line',
      demultiplexer: 'A device that takes a single input signal and routes it to one of several possible output lines',
      consumer: 'Consumer" refers to a device that utilizes electrical energy to perform a function, similar to LEDs, lamps, or fans, converting electrical power into light or motion.'
    }
  end

  def self.export_to_json()
    components_file = './db/samples/components.json'
    control_pins_file = './db/samples/control_pins.json'

    components_data = Component.all.as_json
    File.open(components_file, "w") do |f|
      f.write(JSON.pretty_generate(components_data))
    end

    control_pins_data = ControlPin.all.as_json
    File.open(control_pins_file, "w") do |f|
      f.write(JSON.pretty_generate(control_pins_data))
    end

    puts "Export abgeschlossen: \n- Components: #{components_file}\n- Control Pins: #{control_pins_file}"
  end

  def self.import_from_json()
    components_file = './db/samples/components.json'
    control_pins_file = './db/samples/control_pins.json'

    components_data = JSON.parse(File.read(components_file))
    control_pins_data = JSON.parse(File.read(control_pins_file))

    control_pins_by_component_id = control_pins_data.group_by { |pin| pin['component_id'] }

    components_data.each do |component_data|
      component = Component.create!(component_data.except('id', 'created_at', 'updated_at'))

      control_pins_for_component = control_pins_by_component_id[component_data['id']] || []
      control_pins_for_component.each do |pin_data|
        component.control_pins.create!(pin_data.except('id', 'component_id', 'created_at', 'updated_at'))
      end
    end
  end

  def as_json(options = {})
    # Nur, falls Optionen explizit festgelegt werden, Assoziationen inklusiv anwenden
    if options[:include].nil?
      options[:include] = {}
    end

    if options[:methods].nil?
      options[:methods] = []
    end

    options[:methods] << :image_url unless options[:methods].include?(:image_url)

    super(options)
  end

  def image_url
    Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) if image.attached?
  end

  def circuit
    incoming_circuit = incoming_connections.includes(:circuit).first&.circuit
    outgoing_circuit = outgoing_connections.includes(:circuit).first&.circuit
    incoming_circuit || outgoing_circuit
  end
end