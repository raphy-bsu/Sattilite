class SensorSerializer < ActiveModel::Serializer
  attributes :name
  attributes :abbr

  has_many :values
end
