# == Schema Information
#
# Table name: infos
#
#  id         :integer          not null, primary key
#  temp       :string
#  hum        :string
#  created_at :datetime
#  updated_at :datetime
#

class Info < ActiveRecord::Base
  validates :hum, presence: true
  validates :temp, presence: true
end
