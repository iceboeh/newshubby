require 'test_helper'

class CompanyLaunchesControllerTest < ActionController::TestCase
  setup do
    @company_launch = company_launches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:company_launches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company_launch" do
    assert_difference('CompanyLaunch.count') do
      post :create, company_launch: { newsroom_id: @company_launch.newsroom_id, title: @company_launch.title }
    end

    assert_redirected_to company_launch_path(assigns(:company_launch))
  end

  test "should show company_launch" do
    get :show, id: @company_launch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @company_launch
    assert_response :success
  end

  test "should update company_launch" do
    patch :update, id: @company_launch, company_launch: { newsroom_id: @company_launch.newsroom_id, title: @company_launch.title }
    assert_redirected_to company_launch_path(assigns(:company_launch))
  end

  test "should destroy company_launch" do
    assert_difference('CompanyLaunch.count', -1) do
      delete :destroy, id: @company_launch
    end

    assert_redirected_to company_launches_path
  end
end
