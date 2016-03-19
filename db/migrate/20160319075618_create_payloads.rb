class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.integer :time
      t.float :temperature
      t.float :humidity

      t.timestamps
    end
  end
end
