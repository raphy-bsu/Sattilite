# == Schema Information
#
# Table name: sensors
#
#  id          :integer          not null, primary key
#  name        :string
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  val_type    :integer
#
# Indexes
#
#  index_sensors_on_category_id  (category_id)
#

class Sensor < ActiveRecord::Base
  belongs_to :category
  has_many :values

  validates :category_id, presence: true
  validates :val_type, presence: true
  validates :name, uniqueness: true, presence: true

  enum val_type: [:float, :integer, :string, :boolean]
end
