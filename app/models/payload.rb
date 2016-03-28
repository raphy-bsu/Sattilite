# == Schema Information
#
# Table name: payloads
#
#  id          :integer          not null, primary key
#  time        :integer
#  temperature :float
#  humidity    :float
#  created_at  :datetime
#  updated_at  :datetime
#

class Payload < ActiveRecord::Base
  validates :time, presence: true
  validates :temperature, presence: true
  validates :humidity, presence: true
end
