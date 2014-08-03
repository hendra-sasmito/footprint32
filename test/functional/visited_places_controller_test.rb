require 'test_helper'

class VisitedPlacesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
