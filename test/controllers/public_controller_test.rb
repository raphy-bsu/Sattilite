require 'test_helper'

class PublicControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

end
