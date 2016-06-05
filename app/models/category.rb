# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  abbr       :string
#

class Category < ActiveRecord::Base
  has_many :sensors, dependent: :destroy

  validates :name, :abbr, presence: true, uniqueness: true
end
