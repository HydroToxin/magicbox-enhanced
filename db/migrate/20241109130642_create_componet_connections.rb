class CreateComponetConnections < ActiveRecord::Migration[7.1]
  def change
    create_table :component_connections do |t|
      t.references :source_component, null: false, foreign_key: { to_table: :components }
      t.references :target_component, null: false, foreign_key: { to_table: :components }
      t.text :description

      t.references :circuit, foreign_key: true

      t.timestamps
    end
  end
end
