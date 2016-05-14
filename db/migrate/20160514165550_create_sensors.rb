class CreateSensors < ActiveRecord::Migration
  def change
    create_table :sensors do |t|
      t.string :name
      t.belongs_to :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :sensors, :categories
  end
end
