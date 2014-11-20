require 'test_helper'

class PressreleaseTypesControllerTest < ActionController::TestCase
  setup do
    @pressrelease_type = pressrelease_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pressrelease_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pressrelease_type" do
    assert_difference('PressreleaseType.count') do
      post :create, pressrelease_type: { name: @pressrelease_type.name }
    end

    assert_redirected_to pressrelease_type_path(assigns(:pressrelease_type))
  end

  test "should show pressrelease_type" do
    get :show, id: @pressrelease_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pressrelease_type
    assert_response :success
  end

  test "should update pressrelease_type" do
    patch :update, id: @pressrelease_type, pressrelease_type: { name: @pressrelease_type.name }
    assert_redirected_to pressrelease_type_path(assigns(:pressrelease_type))
  end

  test "should destroy pressrelease_type" do
    assert_difference('PressreleaseType.count', -1) do
      delete :destroy, id: @pressrelease_type
    end

    assert_redirected_to pressrelease_types_path
  end
end
