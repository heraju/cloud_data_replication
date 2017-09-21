require 'test_helper'

class DownloadsControllerTest < ActionController::TestCase
  setup do
    @download = downloads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:downloads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create download" do
    assert_difference('Download.count') do
      post :create, download: { apporve: @download.apporve, description: @download.description, user_id: @download.user_id, user_upload_id: @download.user_upload_id }
    end

    assert_redirected_to download_path(assigns(:download))
  end

  test "should show download" do
    get :show, id: @download
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @download
    assert_response :success
  end

  test "should update download" do
    patch :update, id: @download, download: { apporve: @download.apporve, description: @download.description, user_id: @download.user_id, user_upload_id: @download.user_upload_id }
    assert_redirected_to download_path(assigns(:download))
  end

  test "should destroy download" do
    assert_difference('Download.count', -1) do
      delete :destroy, id: @download
    end

    assert_redirected_to downloads_path
  end
end