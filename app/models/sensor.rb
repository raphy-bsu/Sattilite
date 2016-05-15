# == Schema Information
#
# Table name: sensors
#
#  id          :integer          not null, primary key
#  name        :string
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_sensors_on_category_id  (category_id)
#

class Sensor < ActiveRecord::Base
  belongs_to :category
end
