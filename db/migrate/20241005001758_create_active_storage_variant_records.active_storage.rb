# frozen_string_literal: true

# This migration comes from active_storage (originally 20191206030411)
class CreateActiveStorageVariantRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :active_storage_variant_records, id: primary_key_type, if_not_exists: true do |t|
      t.references :blob, null: false, foreign_key: { to_table: :active_storage_blobs }
      t.string :variation_digest, null: false

      t.index %i[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
    end
  end

  private

  def primary_key_type
    config = Rails.configuration.generators
    config.options[config.orm][:primary_key_type] || :primary_key
  end

  def blobs_primary_key_type
    pkey_name = connection.primary_key(:active_storage_blobs)
    pkey_column = connection.columns(:active_storage_blobs).find { |c| c.name == pkey_name }
    pkey_column.bigint? ? :bigint : pkey_column.type
  end
end
