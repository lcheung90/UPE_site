require 'test_helper'

class SolvesControllerTest < ActionController::TestCase
  setup do
    @solf = solves(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:solves)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create solf" do
    assert_difference('Solf.count') do
      post :create, solf: { question_id: @solf.question_id, user_id: @solf.user_id }
    end

    assert_redirected_to solf_path(assigns(:solf))
  end

  test "should show solf" do
    get :show, id: @solf
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @solf
    assert_response :success
  end

  test "should update solf" do
    put :update, id: @solf, solf: { question_id: @solf.question_id, user_id: @solf.user_id }
    assert_redirected_to solf_path(assigns(:solf))
  end

  test "should destroy solf" do
    assert_difference('Solf.count', -1) do
      delete :destroy, id: @solf
    end

    assert_redirected_to solves_path
  end
end
