# == Schema Information
#
# Table name: infos
#
#  id         :integer          not null, primary key
#  temp       :string(255)
#  hum        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Info < ActiveRecord::Base
end
