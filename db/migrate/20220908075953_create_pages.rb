class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.string :url, null: false

      t.index :url

      t.timestamps
    end
  end
end
