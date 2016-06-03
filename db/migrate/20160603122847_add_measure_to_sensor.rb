class AddMeasureToSensor < ActiveRecord::Migration
  def change
    add_column :sensors, :measure, :string
  end
end
