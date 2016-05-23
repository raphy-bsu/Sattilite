class AddTimeToValue < ActiveRecord::Migration
  def change
    add_column :values, :time, :integer
  end
end
