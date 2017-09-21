require 'test_helper'

class UserUploadsControllerTest < ActionController::TestCase
  setup do
    @user_upload = user_uploads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_uploads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_upload" do
    assert_difference('UserUpload.count') do
      post :create, user_upload: { file: @user_upload.file, user: @user_upload.user }
    end

    assert_redirected_to user_upload_path(assigns(:user_upload))
  end

  test "should show user_upload" do
    get :show, id: @user_upload
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_upload
    assert_response :success
  end

  test "should update user_upload" do
    patch :update, id: @user_upload, user_upload: { file: @user_upload.file, user: @user_upload.user }
    assert_redirected_to user_upload_path(assigns(:user_upload))
  end

  test "should destroy user_upload" do
    assert_difference('UserUpload.count', -1) do
      delete :destroy, id: @user_upload
    end

    assert_redirected_to user_uploads_path
  end
end
