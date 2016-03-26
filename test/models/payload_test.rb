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

require 'test_helper'

class PayloadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
