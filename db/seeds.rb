# frozen_string_literal: true

require 'csv'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

# create default user
User.create(username: 'Admin', email: 'admin@example.com', password: 'changeme', password_confirmation: 'changeme',
            admin: true)

# parse strains
strains_csv = Rails.root.join('db', 'samples', 'strains-kushy_api.2017-11-14.csv')
CSV.parse(File.new(strains_csv), col_sep: ',', headers: false) do |row|
  Strain.create!(
    name: (row[3].present? ? row[3] : 'Unknown'),
    description: row[6] && (row[6] != 'NULL') ? row[6] : nil,
    strain_type: row[7] && (row[7] != 'type') ? row[7].downcase.to_sym : nil,
    crosses: row[8] && (row[8] != 'NULL') ? row[8] : nil,
    breeder: row[9] && (row[9] != 'NULL') ? row[9] : nil,
    effects: row[10] && (row[10] != 'NULL') ? row[10].split(',').map { |e| e.downcase.strip } : nil,
    ailments: row[11] && (row[11] != 'NULL') ? row[11].split(',').map { |e| e.downcase.strip } : nil,
    flavors: row[12] && (row[12] != 'NULL') ? row[12].split(',').map { |e| e.downcase.strip } : nil,
    location: row[13] && (row[13] != 'NULL') ? row[13] : nil,
    terpenes: row[14] && (row[14] != 'NULL') ? row[14] : nil
  )
end

Strain.first.destroy

# create default room
r = Room.create(name: 'Room 1', room_type: 0, length: 60, width: 60, height: 140)

# create default data types
t = DataType.create(name: 'temperature')
h = DataType.create(name: 'humidity')
DataType.create(name: 'soil_moisture')
DataType.create(name: 'water_level')

DataType.create(name: 'weather_temperature')
DataType.create(name: 'weather_humidity')
DataType.create(name: 'weather_pressure')
DataType.create(name: 'weather_clouds')
DataType.create(name: 'weather_wind_speed')
DataType.create(name: 'weather_wind_angle')

DataType.create(name: 'cpu_usage')
DataType.create(name: 'cpu_temp')
DataType.create(name: 'cpu_voltage')
DataType.create(name: 'memory_used')
DataType.create(name: 'memory_free')

DevicesDataType.create(device_id: 1, data_type_id: 1, unit: '°C')
DevicesDataType.create(device_id: 1, data_type_id: 2, unit: '%')
DevicesDataType.create(device_id: 2, data_type_id: 3, unit: '%')
DevicesDataType.create(device_id: 3, data_type_id: 4, unit: '%')

# create default device in the room
Component.import_from_json

d = Device.create!(room_id: r.id, device_type: :sensor, device_state: 2, name: 'Temp/hum', product_reference: 'dht11',
                   description: 'Temperature/humidity sensor (DHT11)', component: Component.first)

s = Sample.create(
  product_reference: 'System',
  data_type_id: DataType.first.id,
  value: '22',
  category_name: 'cpu',
  html_color: 'red',
  unit: '°C'
)

d.data_types << t
d.data_types << h
d.samples << s
d.save!


Device.create(device_type: 1, device_state: 2, name: 'Temperature/humidity', product_reference: 'vma311',
              description: 'Temperature/humidity (NTC/DHT11) sensor for Arduino', component: Component.first)
Device.create(device_type: 1, device_state: 2, name: 'Soil moisture', product_reference: 'vma303',
              description: 'Soil moisture sensor for Arduino', component: Component.first)
Device.create(device_type: 1, device_state: 2, name: 'Water level', product_reference: 'vma303',
              description: 'Water level sensor for Arduino', component: Component.first)
Device.create(device_type: 2, device_state: 0, name: 'Cooling fan', product_reference: 'SanACE40',
              description: 'Fan used to cool the environment when the temperature goes up too much', component: Component.first)
Device.create(device_type: 3, device_state: 0, name: 'Water pump', product_reference: 'unknow',
              description: 'Water pump used to fill the water tank when level goes down', component: Component.first)
Device.create(device_type: 4, device_state: 0, name: 'Air pump', product_reference: 'unknow',
              description: 'Air pump to brew and keep hight level of oxygen in the water tank', component: Component.first)

Device.create!(room_id: r.id, device_type: :light, device_state: 0, name: 'Light',
               product_reference: 'unknow', description: 'Light giving some sun to the room', component: Component.first)
Device.create!(room_id: r.id, device_type: :extractor, device_state: 0, name: 'Extractor',
               product_reference: 'unknow', description: 'Extractor device pushing used air out the room', component: Component.first)
Device.create!(room_id: r.id, device_type: :intractor, device_state: 0, name: 'Intractor',
               product_reference: 'unknow', description: 'Intractor device sucking new air into the room', component: Component.first)
Device.create!(room_id: r.id, device_type: :fan, device_state: 0, name: 'Fan',
               product_reference: 'unknow', description: 'Fan that moves the air inside the room', component: Component.first)
Device.create!(room_id: r.id, device_type: :heater, device_state: 0, name: 'Heater',
               product_reference: 'unknow', description: 'Heater used to maintain the right temperature', component: Component.first)
Device.create!(room_id: r.id, device_type: :water_pump, device_state: 0, name: 'Water',
               product_reference: 'unknow', description: 'A pump that manages an auto-catering system', component: Component.first)

water_category = Category.create(name: 'Water', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit')
nutrients_category = Category.create(name: 'Nutrients',
                                     description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit')
Category.create(name: 'Air', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit')
Category.create(name: 'Light', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit')


Resource.create(
  name: 'Water quantity',
  shortname: 'H2O',
  description: 'Amount of liquid water',
  category_id: water_category.id,
  choices: ['Spring water', 'Well water', 'Rainwater', 'Filtered water'],
  units: %w[l dl cl ml]
)

Resource.create(
  name: 'Water type',
  shortname: 'Type',
  description: 'Type of water used for watering your grows',
  category_id: water_category.id,
  choices: ['Tap water', 'Mineral water', 'Purified water', 'Distiled water (reverse osmosis)'],
  units: %w[l dl cl ml]
)


Resource.create(
  name: 'pH',
  shortname: 'pH',
  description: 'Scale used to specify the acidity or basicity of an aqueous solution',
  category_id: water_category.id,
  choices: ['Acidic', 'Neutral', 'Alkaline'],
  units: ['pH']
)

Resource.create(
  name: 'EC',
  shortname: 'EC',
  description: "Electrical conductivity is the measure of a material's ability to allow the transport of an electric charge",
  category_id: water_category.id,
  choices: ['Conductivity'],
  units: ['µS/cm', 'mS/cm']
)

# NUTRIENTS
Resource.create(
  name: 'Nitrogen',
  shortname: 'N',
  description: 'Nitrogen is a nonmetal chemical element essential for plant grow',
  category_id: nutrients_category.id,
  choices: ['Ammonium', 'Nitrate', 'Urea'],
  units: ['ppm', 'mg/L']
)

Resource.create(
  name: 'Phosphorus',
  shortname: 'P',
  description: 'Phosphates are required for the biosynthesis of genetic material as well as ATP, essential for life.',
  category_id: nutrients_category.id,
  choices: ['Orthophosphate', 'Total Phosphate'],
  units: ['ppm', 'mg/L']
)

Resource.create(
  name: 'Potatium',
  shortname: 'K',
  description: 'Potatium provides the ionic environment for metabolic processes in the cytosol, and as such functions as a regulator of various processes including growth regulation.',
  category_id: nutrients_category.id,
  choices: ['Soluble', 'Potash'],
  units: ['ppm', 'mg/L']
)

# create default scenario
growing_scenario = Scenario.import('db/samples/Growing.json', 'Growing')
Scenario.import('db/samples/Blooming.json', 'Blooming')
climat_scenario = Scenario.import('db/samples/Climat.json', 'Climat')
watering_scenario = Scenario.import('db/samples/Watering.json', 'Watering')

r.scenarios << [growing_scenario, climat_scenario, watering_scenario]
r.save!

Grow.create! description: 'Test', start_date: Time.now, flowering: 1, grow_status: :seedling, birth_type: 'from_seed'

s = Subject.create! name: 'Test Subject', grow: Grow.first, room: Room.last

Observation.create! user: User.first, grow: Grow.first, body: 'Observation Test', water: true, nutrients: 10, room: r, subject_ids: [s.id]
