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

ActiveRecord::Schema[7.1].define(version: 2024_10_05_001759) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "alert_push_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "alert_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "alert_users", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.uuid "alert_id", default: -> { "gen_random_uuid()" }, null: false
  end

  create_table "alerts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "alert_type"
    t.integer "data_type_id"
    t.integer "resource_id"
    t.integer "user_id"
    t.integer "operator"
    t.float "value"
    t.text "message"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "latest_send", precision: nil
    t.boolean "enabled", default: true
    t.boolean "push_enabled", default: false
  end

  create_table "batches", force: :cascade do |t|
    t.integer "grow_id"
    t.integer "harvest_id"
    t.string "name"
    t.float "total_weight"
    t.float "batch_weight"
    t.integer "batch_count"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "batch_type", default: 0
    t.float "price_per_weight", default: 0.0
    t.float "batch_price", default: 0.0
    t.index ["grow_id"], name: "index_batches_on_grow_id"
    t.index ["harvest_id"], name: "index_batches_on_harvest_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "condition_groups", force: :cascade do |t|
    t.integer "scenario_id"
    t.string "name"
    t.boolean "enabled"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["scenario_id"], name: "index_condition_groups_on_scenario_id"
  end

  create_table "conditions", force: :cascade do |t|
    t.integer "data_type_id"
    t.integer "predicate"
    t.integer "target_value"
    t.time "start_time"
    t.time "end_time"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "condition_group_id"
    t.integer "condition_type", default: 0
    t.integer "logic", default: 0
    t.integer "duration"
    t.datetime "last_duration_checked_at", precision: nil
    t.index ["condition_group_id"], name: "index_conditions_on_condition_group_id"
  end

  create_table "data_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "devices", force: :cascade do |t|
    t.integer "device_type"
    t.integer "device_state"
    t.string "name"
    t.string "product_reference"
    t.text "description"
    t.integer "pin_type", default: 0
    t.integer "pin_number", default: 0
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "last_start_date", precision: nil
    t.integer "default_duration", default: 1
    t.integer "room_id"
    t.boolean "use_duration", default: false
    t.float "watts", default: 0.0
    t.float "volts", default: 0.0
    t.float "amperes", default: 0.0
    t.string "custom_identifier"
    t.index ["room_id"], name: "index_devices_on_room_id"
  end

  create_table "devices_data_types", force: :cascade do |t|
    t.integer "device_id"
    t.integer "data_type_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["data_type_id"], name: "index_devices_data_types_on_data_type_id"
    t.index ["device_id"], name: "index_devices_data_types_on_device_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "event_type"
    t.text "message"
    t.json "data"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "room_id"
    t.integer "device_id"
    t.string "eventable_type"
    t.bigint "eventable_id"
    t.integer "user_id"
    t.index ["eventable_type", "eventable_id"], name: "index_events_on_eventable_type_and_eventable_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "grows", force: :cascade do |t|
    t.text "description"
    t.date "start_date"
    t.integer "substrate"
    t.integer "flowering"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "grow_status", default: 0
    t.integer "number_of_subjects", default: 4
    t.integer "seedling_weeks", default: 1
    t.integer "vegging_weeks", default: 2
    t.integer "flowering_weeks", default: 7
    t.integer "flushing_weeks", default: 1
    t.integer "drying_weeks", default: 1
    t.integer "curing_weeks", default: 3
    t.integer "birth_type", default: 0
    t.integer "mother_id"
    t.float "estimated_weight_by_square_meter", default: 0.0
    t.boolean "auto_update_status", default: true
  end

  create_table "harvests", force: :cascade do |t|
    t.bigint "grow_id"
    t.float "harvested_trim_weight", default: 0.0
    t.float "harvested_waste_weight", default: 0.0
    t.float "harvested_bud_weight", default: 0.0
    t.float "dry_trim_weight", default: 0.0
    t.float "dry_bud_weight", default: 0.0
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["grow_id"], name: "index_harvests_on_grow_id"
  end

  create_table "issues", force: :cascade do |t|
    t.integer "resource_id"
    t.integer "subject_id"
    t.integer "observation_id"
    t.integer "severity"
    t.integer "issue_type"
    t.integer "issue_status"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["observation_id"], name: "index_issues_on_observation_id"
    t.index ["resource_id"], name: "index_issues_on_resource_id"
    t.index ["subject_id"], name: "index_issues_on_subject_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "read", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "notifiable_type", default: "Alert"
    t.boolean "notify_email", default: true
    t.boolean "notify_push", default: true
    t.uuid "notifiable_id"
    t.string "notified_type"
    t.bigint "notified_id"
    t.index ["notified_type", "notified_id"], name: "index_notifications_on_notified_type_and_notified_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "observations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "grow_id"
    t.integer "subject_id"
    t.text "body"
    t.float "water", default: 0.0
    t.float "nutrients", default: 0.0
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "room_id"
    t.index ["grow_id"], name: "index_observations_on_grow_id"
    t.index ["room_id"], name: "index_observations_on_room_id"
    t.index ["subject_id"], name: "index_observations_on_subject_id"
    t.index ["user_id"], name: "index_observations_on_user_id"
  end

  create_table "observations_subjects", force: :cascade do |t|
    t.integer "observation_id"
    t.integer "subject_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["observation_id"], name: "index_observations_subjects_on_observation_id"
    t.index ["subject_id"], name: "index_observations_subjects_on_subject_id"
  end

  create_table "operations", force: :cascade do |t|
    t.string "command"
    t.integer "delay"
    t.integer "retries"
    t.string "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "duration"
    t.integer "condition_group_id"
    t.integer "device_type", default: 0
  end

  create_table "push_devices", force: :cascade do |t|
    t.string "device_id"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["device_id"], name: "index_push_devices_on_device_id"
    t.index ["user_id"], name: "index_push_devices_on_user_id"
  end

  create_table "resource_datas", force: :cascade do |t|
    t.integer "resource_id"
    t.integer "observation_id"
    t.integer "subject_id"
    t.string "value"
    t.string "unit"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["observation_id"], name: "index_resource_datas_on_observation_id"
    t.index ["resource_id"], name: "index_resource_datas_on_resource_id"
    t.index ["subject_id"], name: "index_resource_datas_on_subject_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.string "shortname"
    t.text "description"
    t.integer "category_id"
    t.string "choices", default: [], array: true
    t.string "units", default: [], array: true
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
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
    t.integer "data_type_id"
    t.text "value"
    t.string "unit"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "device_id"
    t.string "html_color"
    t.string "category_name", default: "default"
    t.index ["created_at"], name: "index_samples_on_created_at"
    t.index ["data_type_id"], name: "index_samples_on_data_type_id"
  end

  create_table "scenarios", force: :cascade do |t|
    t.string "name"
    t.integer "subject_id"
    t.string "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "enabled", default: false
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
    t.integer "strain_type"
    t.integer "crosses"
    t.string "breeder"
    t.text "effects", default: [], array: true
    t.text "ailments", default: [], array: true
    t.text "flavors", default: [], array: true
    t.string "location"
    t.string "terpenes"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "room_id"
    t.integer "grow_id"
    t.integer "birth_type", default: 0
    t.integer "mother_id"
    t.integer "strain_id"
    t.index ["grow_id"], name: "index_subjects_on_grow_id"
    t.index ["mother_id"], name: "index_subjects_on_mother_id"
    t.index ["room_id"], name: "index_subjects_on_room_id"
    t.index ["strain_id"], name: "index_subjects_on_strain_id"
  end

  create_table "todos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "todo_status", default: 0
    t.integer "user_id"
    t.datetime "date", precision: nil
    t.text "body"
    t.boolean "notify_email", default: true
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "notify_push", default: true
    t.datetime "notified_date", precision: nil
    t.integer "renotify_every_minute", default: 15
    t.index ["user_id"], name: "index_todos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "authentication_token", limit: 30
    t.string "username"
    t.boolean "is_admin", default: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weeks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "week_number"
    t.integer "week_type"
    t.date "start_date"
    t.date "end_date"
    t.integer "grow_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["grow_id"], name: "index_weeks_on_grow_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "room_scenarios", "rooms"
  add_foreign_key "room_scenarios", "scenarios"
end
