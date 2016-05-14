class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.integer :type
      t.float :val_float
      t.integer :val_int
      t.text :val_str
      t.boolean :val_bool
      t.belongs_to :sensor, index: true

      t.timestamps null: false
    end
    add_foreign_key :values, :sensors
  end
end
