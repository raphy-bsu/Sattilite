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
#  abbr        :string
#
# Indexes
#
#  index_sensors_on_category_id  (category_id)
#

class Sensor < ActiveRecord::Base
  belongs_to :category
  has_many :values, dependent: :destroy

  validates :category_id, presence: true
  validates :val_type, presence: true
  validates :name, uniqueness: true, presence: true

  enum val_type: [:float, :integer, :string, :boolean]

  def insert_value(value, time)
    case self.val_type
      when 'float'
        key = :val_float
        value = value.to_f
      when 'integer'
        key = :val_int
        value = value.to_i
      when 'string'
        key = :val_str
        value = value.to_s
      when 'boolean'
        key = :val_bool
        value = value.include? 'true' ? true : false
      else
        raise ArgumentError, "This type is not supported"
    end
    self.values.create!(key => value, time: time)
  end
end
