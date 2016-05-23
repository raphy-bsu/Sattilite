class AddAbbrToSensorsAndCategories < ActiveRecord::Migration
  def change
    add_column :categories, :abbr, :string
    add_column :sensors, :abbr, :string
  end
end
