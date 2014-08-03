require 'test_helper'

class VisitedCitiesControllerTest < ActionController::TestCase
  setup do
    @visited_city = visited_cities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:visited_cities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create visited_city" do
    assert_difference('VisitedCity.count') do
      post :create, visited_city: { city_id: @visited_city.city_id, user_id: @visited_city.user_id }
    end

    assert_redirected_to visited_city_path(assigns(:visited_city))
  end

  test "should show visited_city" do
    get :show, id: @visited_city
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @visited_city
    assert_response :success
  end

  test "should update visited_city" do
    put :update, id: @visited_city, visited_city: { city_id: @visited_city.city_id, user_id: @visited_city.user_id }
    assert_redirected_to visited_city_path(assigns(:visited_city))
  end

  test "should destroy visited_city" do
    assert_difference('VisitedCity.count', -1) do
      delete :destroy, id: @visited_city
    end

    assert_redirected_to visited_cities_path
  end
end
