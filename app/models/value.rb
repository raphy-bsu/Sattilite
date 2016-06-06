# == Schema Information
#
# Table name: values
#
#  id         :integer          not null, primary key
#  val_float  :float
#  val_int    :integer
#  val_str    :text
#  val_bool   :boolean
#  sensor_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  val_type   :integer
#  time       :integer
#
# Indexes
#
#  index_values_on_sensor_id  (sensor_id)
#

class Value < ActiveRecord::Base
  belongs_to :sensor

  validates_presence_of :time

  def get_value
    case self.sensor.val_type
      when 'float'
        self.val_float
      when 'integer'
        self.val_int
      when 'string'
        self.val_str
      when 'boolean'
        self.val_bool
      else
        raise Exception, "This type is not supported"
    end

  end

  def formatted_time
    Time.at(time).strftime("%F %T")
  end
end
