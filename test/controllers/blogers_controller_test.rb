require 'test_helper'

class BlogersControllerTest < ActionController::TestCase
  setup do
    @bloger = blogers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bloggers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bloger" do
    assert_difference('Bloger.count') do
      post :create, bloger: { email: @bloger.email, name: @bloger.name, password: @bloger.password }
    end

    assert_redirected_to bloger_path(assigns(:bloger))
  end

  test "should show bloger" do
    get :show, id: @bloger
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bloger
    assert_response :success
  end

  test "should update bloger" do
    patch :update, id: @bloger, bloger: { email: @bloger.email, name: @bloger.name, password: @bloger.password }
    assert_redirected_to bloger_path(assigns(:bloger))
  end

  test "should destroy bloger" do
    assert_difference('Bloger.count', -1) do
      delete :destroy, id: @bloger
    end

    assert_redirected_to blogers_path
  end
end
