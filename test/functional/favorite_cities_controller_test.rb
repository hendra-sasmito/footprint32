require 'test_helper'

class FavoriteCitiesControllerTest < ActionController::TestCase
  setup do
    @favorite_city = favorite_cities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:favorite_cities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create favorite_city" do
    assert_difference('FavoriteCity.count') do
      post :create, favorite_city: { city_id: @favorite_city.city_id, user_id: @favorite_city.user_id }
    end

    assert_redirected_to favorite_city_path(assigns(:favorite_city))
  end

  test "should show favorite_city" do
    get :show, id: @favorite_city
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @favorite_city
    assert_response :success
  end

  test "should update favorite_city" do
    put :update, id: @favorite_city, favorite_city: { city_id: @favorite_city.city_id, user_id: @favorite_city.user_id }
    assert_redirected_to favorite_city_path(assigns(:favorite_city))
  end

  test "should destroy favorite_city" do
    assert_difference('FavoriteCity.count', -1) do
      delete :destroy, id: @favorite_city
    end

    assert_redirected_to favorite_cities_path
  end
end
