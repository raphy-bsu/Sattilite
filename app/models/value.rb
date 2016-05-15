# == Schema Information
#
# Table name: values
#
#  id         :integer          not null, primary key
#  type       :integer
#  val_float  :float
#  val_int    :integer
#  val_str    :text
#  val_bool   :boolean
#  sensor_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_values_on_sensor_id  (sensor_id)
#

class Value < ActiveRecord::Base
  belongs_to :sensor
end
