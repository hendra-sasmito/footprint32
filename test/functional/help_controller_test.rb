require 'test_helper'

class HelpControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get cookies" do
    get :cookies
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get terms" do
    get :terms
    assert_response :success
  end

end
