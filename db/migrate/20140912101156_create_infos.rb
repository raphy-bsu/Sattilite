class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      [:temp, :hum].each do |field|
        t.string field
      end
      t.timestamps
    end
  end
end
