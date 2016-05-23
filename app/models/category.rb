# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  abbr       :string
#

class Category < ActiveRecord::Base
  belongs_to :user
  has_many :sensors, dependent: :destroy
end
