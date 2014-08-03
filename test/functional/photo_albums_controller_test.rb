require 'test_helper'

class PhotoAlbumsControllerTest < ActionController::TestCase
  setup do
    @photo_album = photo_albums(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:photo_albums)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create photo_album" do
    assert_difference('PhotoAlbum.count') do
      post :create, photo_album: { description: @photo_album.description, name: @photo_album.name, privacy: @photo_album.privacy }
    end

    assert_redirected_to photo_album_path(assigns(:photo_album))
  end

  test "should show photo_album" do
    get :show, id: @photo_album
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @photo_album
    assert_response :success
  end

  test "should update photo_album" do
    put :update, id: @photo_album, photo_album: { description: @photo_album.description, name: @photo_album.name, privacy: @photo_album.privacy }
    assert_redirected_to photo_album_path(assigns(:photo_album))
  end

  test "should destroy photo_album" do
    assert_difference('PhotoAlbum.count', -1) do
      delete :destroy, id: @photo_album
    end

    assert_redirected_to photo_albums_path
  end
end
