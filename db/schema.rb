# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_11_19_175450) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.string "service_name", null: false
    t.jsonb "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
    t.index ["blob_id"], name: "index_active_storage_variant_records_on_blob_id"
  end

  create_table "alert_push_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "alert_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["alert_id"], name: "index_alert_push_users_on_alert_id"
    t.index ["user_id"], name: "index_alert_push_users_on_user_id"
  end

  create_table "alert_users", force: :cascade do |t|
    t.bigint "alert_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["alert_id"], name: "index_alert_users_on_alert_id"
    t.index ["user_id"], name: "index_alert_users_on_user_id"
  end

  create_table "alerts", force: :cascade do |t|
    t.integer "alert_type"
    t.integer "operator"
    t.boolean "enabled"
    t.boolean "push_enabled"
    t.float "value"
    t.text "message"
    t.datetime "alerts", precision: nil
    t.bigint "data_type_id"
    t.bigint "resource_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["data_type_id"], name: "index_alerts_on_data_type_id"
    t.index ["resource_id"], name: "index_alerts_on_resource_id"
  end

  create_table "batches", force: :cascade do |t|
    t.string "name"
    t.float "total_weight"
    t.float "batch_weight"
    t.float "price_per_weight", default: 0.0
    t.float "batch_price", default: 0.0
    t.integer "batch_count"
    t.integer "batch_type", default: 0
    t.bigint "harvest_id"
    t.bigint "grow_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["grow_id"], name: "index_batches_on_grow_id"
    t.index ["harvest_id"], name: "index_batches_on_harvest_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "circuits", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "component_connections", force: :cascade do |t|
    t.bigint "source_component_id", null: false
    t.bigint "target_component_id", null: false
    t.text "description"
    t.bigint "circuit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circuit_id"], name: "index_component_connections_on_circuit_id"
    t.index ["source_component_id"], name: "index_component_connections_on_source_component_id"
    t.index ["target_component_id"], name: "index_component_connections_on_target_component_id"
  end

  create_table "component_pin_connections", force: :cascade do |t|
    t.bigint "source_control_pin_id", null: false
    t.bigint "target_control_pin_id", null: false
    t.bigint "component_connection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["component_connection_id"], name: "index_component_pin_connections_on_component_connection_id"
    t.index ["source_control_pin_id"], name: "index_component_pin_connections_on_source_control_pin_id"
    t.index ["target_control_pin_id"], name: "index_component_pin_connections_on_target_control_pin_id"
  end

  create_table "components", force: :cascade do |t|
    t.string "name", null: false
    t.string "component_type", null: false
    t.string "model"
    t.string "version"
    t.boolean "active"
    t.boolean "microcontroller", default: false
    t.boolean "multiplexer", default: false
    t.string "description"
    t.string "address"
    t.decimal "voltage", precision: 5, scale: 2
    t.decimal "standby_ampere"
    t.decimal "max_ampere"
    t.decimal "watt"
    t.decimal "power", precision: 8, scale: 4
    t.decimal "temperature", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "condition_groups", force: :cascade do |t|
    t.string "name"
    t.boolean "enabled"
    t.bigint "scenario_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["scenario_id"], name: "index_condition_groups_on_scenario_id"
  end

  create_table "conditions", force: :cascade do |t|
    t.integer "predicate"
    t.integer "target_value"
    t.integer "device_state"
    t.integer "condition_type", default: 0
    t.integer "logic", default: 0
    t.integer "duration"
    t.integer "time_duration_hours"
    t.integer "time_duration_minutes"
    t.time "start_time"
    t.time "end_time"
    t.datetime "last_duration_checked_at", precision: nil
    t.bigint "data_type_id"
    t.bigint "device_id"
    t.bigint "condition_group_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["condition_group_id"], name: "index_conditions_on_condition_group_id"
    t.index ["data_type_id"], name: "index_conditions_on_data_type_id"
    t.index ["device_id"], name: "index_conditions_on_device_id"
  end

  create_table "control_pins", force: :cascade do |t|
    t.string "name", null: false
    t.integer "pin_number", null: false
    t.string "pin_color"
    t.boolean "left"
    t.boolean "right"
    t.integer "com_number"
    t.string "pin_function"
    t.string "signal_type"
    t.string "signal_mode"
    t.string "pull_resistor"
    t.string "initial_state"
    t.string "voltage"
    t.string "description"
    t.bigint "component_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["component_id"], name: "index_control_pins_on_component_id"
  end

  create_table "data_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "device_scripts", force: :cascade do |t|
    t.string "name"
    t.string "script_name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.integer "device_type"
    t.integer "device_state"
    t.integer "default_duration", default: 1
    t.string "name"
    t.string "product_reference"
    t.string "custom_identifier"
    t.text "description"
    t.datetime "last_start_date", precision: nil
    t.boolean "use_duration", default: false
    t.bigint "room_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "component_id"
    t.bigint "device_script_id"
    t.index ["component_id"], name: "index_devices_on_component_id"
    t.index ["device_script_id"], name: "index_devices_on_device_script_id"
    t.index ["room_id"], name: "index_devices_on_room_id"
  end

  create_table "devices_data_types", force: :cascade do |t|
    t.bigint "device_id"
    t.bigint "data_type_id"
    t.string "unit"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["data_type_id"], name: "index_devices_data_types_on_data_type_id"
    t.index ["device_id"], name: "index_devices_data_types_on_device_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "event_type"
    t.text "message"
    t.json "data"
    t.bigint "room_id"
    t.bigint "device_id"
    t.bigint "user_id"
    t.string "eventable_type"
    t.bigint "eventable_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["device_id"], name: "index_events_on_device_id"
    t.index ["eventable_type", "eventable_id"], name: "index_events_on_eventable_type_and_eventable_id"
    t.index ["room_id"], name: "index_events_on_room_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "grows", force: :cascade do |t|
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.integer "substrate"
    t.integer "flowering"
    t.integer "grow_status", null: false
    t.integer "number_of_subjects", default: 0
    t.integer "seedling_weeks", default: 0
    t.integer "vegging_weeks", default: 0
    t.integer "flowering_weeks", default: 0
    t.integer "flushing_weeks", default: 0
    t.integer "drying_weeks", default: 0
    t.integer "curing_weeks", default: 0
    t.integer "birth_type"
    t.boolean "auto_update_status", default: true
    t.float "estimated_weight_by_square_meter", default: 0.0
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "harvests", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "harvested_trim_weight", default: 0.0
    t.float "harvested_waste_weight", default: 0.0
    t.float "harvested_bud_weight", default: 0.0
    t.float "dry_trim_weight", default: 0.0
    t.float "dry_bud_weight", default: 0.0
    t.bigint "grow_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["grow_id"], name: "index_harvests_on_grow_id"
  end

  create_table "issues", force: :cascade do |t|
    t.integer "severity"
    t.integer "issue_type"
    t.integer "issue_status"
    t.bigint "resource_id"
    t.bigint "observation_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["observation_id"], name: "index_issues_on_observation_id"
    t.index ["resource_id"], name: "index_issues_on_resource_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.boolean "read", default: false
    t.boolean "notify_email"
    t.string "notified_type"
    t.bigint "notified_id"
    t.string "notifiable_type"
    t.bigint "notifiable_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "observation_resources", force: :cascade do |t|
    t.string "value"
    t.string "choice"
    t.string "unit"
    t.bigint "resource_id"
    t.bigint "observation_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["observation_id"], name: "index_observation_resources_on_observation_id"
    t.index ["resource_id"], name: "index_observation_resources_on_resource_id"
  end

  create_table "observations", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.float "water", default: 0.0
    t.float "nutrients", default: 0.0
    t.integer "duration", default: 0
    t.bigint "user_id"
    t.bigint "grow_id"
    t.bigint "room_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["grow_id"], name: "index_observations_on_grow_id"
    t.index ["room_id"], name: "index_observations_on_room_id"
    t.index ["user_id"], name: "index_observations_on_user_id"
  end

  create_table "observations_subjects", force: :cascade do |t|
    t.bigint "observation_id"
    t.bigint "subject_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["observation_id"], name: "index_observations_subjects_on_observation_id"
    t.index ["subject_id"], name: "index_observations_subjects_on_subject_id"
  end

  create_table "operations", force: :cascade do |t|
    t.string "command"
    t.string "description"
    t.integer "delay"
    t.integer "retries"
    t.integer "duration", default: 0
    t.integer "device_type", default: 0
    t.bigint "condition_group_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["condition_group_id"], name: "index_operations_on_condition_group_id"
  end

  create_table "push_devices", force: :cascade do |t|
    t.bigint "device_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["device_id"], name: "index_push_devices_on_device_id"
    t.index ["user_id"], name: "index_push_devices_on_user_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.string "shortname"
    t.string "choices", default: [], array: true
    t.string "units", default: [], array: true
    t.text "description"
    t.bigint "category_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["category_id"], name: "index_resources_on_category_id"
  end

  create_table "room_scenarios", force: :cascade do |t|
    t.bigint "room_id"
    t.bigint "scenario_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["room_id"], name: "index_room_scenarios_on_room_id"
    t.index ["scenario_id"], name: "index_room_scenarios_on_scenario_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.integer "room_type"
    t.integer "length"
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "samples", force: :cascade do |t|
    t.string "product_reference"
    t.string "unit"
    t.string "html_color"
    t.string "category_name"
    t.text "value"
    t.bigint "data_type_id"
    t.bigint "device_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["created_at"], name: "index_samples_on_created_at"
    t.index ["data_type_id"], name: "index_samples_on_data_type_id"
    t.index ["device_id"], name: "index_samples_on_device_id"
  end

  create_table "scenarios", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "enabled", default: false
    t.boolean "scenarios", default: false
    t.bigint "subject_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["subject_id"], name: "index_scenarios_on_subject_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "strains", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "breeder"
    t.string "location"
    t.string "terpenes"
    t.text "effects", default: [], array: true
    t.text "ailments", default: [], array: true
    t.text "flavors", default: [], array: true
    t.integer "strain_type"
    t.integer "crosses"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.integer "birth_type", default: 0
    t.bigint "room_id"
    t.bigint "grow_id"
    t.bigint "mother_id"
    t.bigint "strain_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["grow_id"], name: "index_subjects_on_grow_id"
    t.index ["mother_id"], name: "index_subjects_on_mother_id"
    t.index ["room_id"], name: "index_subjects_on_room_id"
    t.index ["strain_id"], name: "index_subjects_on_strain_id"
  end

  create_table "todos", force: :cascade do |t|
    t.integer "todo_status", default: 0
    t.integer "renotify_every_minute"
    t.datetime "date", precision: nil
    t.datetime "notified_date", precision: nil
    t.boolean "notify_email", default: true
    t.text "body"
    t.boolean "notify", default: true
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_todos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.string "authentication_token"
    t.string "username"
    t.boolean "admin", default: false
    t.uuid "alert_uuid", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weeks", force: :cascade do |t|
    t.integer "week_number"
    t.integer "week_type"
    t.date "start_date"
    t.date "end_date"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "grow_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["grow_id"], name: "index_weeks_on_grow_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "alert_push_users", "alerts"
  add_foreign_key "alert_push_users", "users"
  add_foreign_key "alert_users", "alerts"
  add_foreign_key "alert_users", "users"
  add_foreign_key "alerts", "data_types"
  add_foreign_key "alerts", "resources"
  add_foreign_key "batches", "grows"
  add_foreign_key "batches", "harvests"
  add_foreign_key "component_connections", "circuits"
  add_foreign_key "component_connections", "components", column: "source_component_id"
  add_foreign_key "component_connections", "components", column: "target_component_id"
  add_foreign_key "component_pin_connections", "control_pins", column: "source_control_pin_id"
  add_foreign_key "component_pin_connections", "control_pins", column: "target_control_pin_id"
  add_foreign_key "condition_groups", "scenarios"
  add_foreign_key "conditions", "condition_groups"
  add_foreign_key "conditions", "data_types"
  add_foreign_key "conditions", "devices"
  add_foreign_key "control_pins", "components"
  add_foreign_key "devices", "components"
  add_foreign_key "devices", "device_scripts"
  add_foreign_key "devices", "rooms"
  add_foreign_key "devices_data_types", "data_types"
  add_foreign_key "devices_data_types", "devices"
  add_foreign_key "events", "devices"
  add_foreign_key "events", "rooms"
  add_foreign_key "events", "users"
  add_foreign_key "harvests", "grows"
  add_foreign_key "issues", "observations"
  add_foreign_key "issues", "resources"
  add_foreign_key "notifications", "users"
  add_foreign_key "observation_resources", "observations"
  add_foreign_key "observation_resources", "resources"
  add_foreign_key "observations", "grows"
  add_foreign_key "observations", "rooms"
  add_foreign_key "observations", "users"
  add_foreign_key "observations_subjects", "observations"
  add_foreign_key "observations_subjects", "subjects"
  add_foreign_key "operations", "condition_groups"
  add_foreign_key "push_devices", "devices"
  add_foreign_key "push_devices", "users"
  add_foreign_key "resources", "categories"
  add_foreign_key "room_scenarios", "rooms"
  add_foreign_key "room_scenarios", "scenarios"
  add_foreign_key "samples", "data_types"
  add_foreign_key "samples", "devices"
  add_foreign_key "scenarios", "subjects"
  add_foreign_key "subjects", "grows"
  add_foreign_key "subjects", "rooms"
  add_foreign_key "subjects", "strains"
  add_foreign_key "subjects", "subjects", column: "mother_id"
  add_foreign_key "todos", "users"
  add_foreign_key "weeks", "grows"
end
