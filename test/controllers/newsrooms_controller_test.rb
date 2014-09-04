require 'test_helper'

class NewsroomsControllerTest < ActionController::TestCase
  setup do
    @newsroom = newsrooms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:newsrooms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create newsroom" do
    assert_difference('Newsroom.count') do
      post :create, newsroom: { company_name: @newsroom.company_name, founded: @newsroom.founded, press_email: @newsroom.press_email, press_phone: @newsroom.press_phone, q_clients: @newsroom.q_clients, q_how_you_achieve: @newsroom.q_how_you_achieve, q_what_you_do: @newsroom.q_what_you_do, q_who_are_you: @newsroom.q_who_are_you, website: @newsroom.website }
    end

    assert_redirected_to newsroom_path(assigns(:newsroom))
  end

  test "should show newsroom" do
    get :show, id: @newsroom
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @newsroom
    assert_response :success
  end

  test "should update newsroom" do
    patch :update, id: @newsroom, newsroom: { company_name: @newsroom.company_name, founded: @newsroom.founded, press_email: @newsroom.press_email, press_phone: @newsroom.press_phone, q_clients: @newsroom.q_clients, q_how_you_achieve: @newsroom.q_how_you_achieve, q_what_you_do: @newsroom.q_what_you_do, q_who_are_you: @newsroom.q_who_are_you, website: @newsroom.website }
    assert_redirected_to newsroom_path(assigns(:newsroom))
  end

  test "should destroy newsroom" do
    assert_difference('Newsroom.count', -1) do
      delete :destroy, id: @newsroom
    end

    assert_redirected_to newsrooms_path
  end
end
