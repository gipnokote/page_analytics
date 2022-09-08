class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :page, null: false, foreign_key: true
      t.string :ip, null: false
      t.integer :event_type, null: false

      t.index :event_type
      t.index :created_at

      t.timestamps
    end
  end
end
