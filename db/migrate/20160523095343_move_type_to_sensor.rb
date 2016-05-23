class MoveTypeToSensor < ActiveRecord::Migration
  def change
    remove_column :values, :type
    add_column :sensors, :val_type, :integer
  end
end
