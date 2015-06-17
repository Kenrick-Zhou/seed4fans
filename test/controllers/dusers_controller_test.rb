require 'test_helper'

class DusersControllerTest < ActionController::TestCase
  setup do
    @duser = dusers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dusers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create duser" do
    assert_difference('Duser.count') do
      post :create, duser: { c_doulist: @duser.c_doulist, c_follower: @duser.c_follower, c_m_collect: @duser.c_m_collect, c_m_do: @duser.c_m_do, c_m_wish: @duser.c_m_wish, error: @duser.error, name: @duser.name, uid: @duser.uid }
    end

    assert_redirected_to duser_path(assigns(:duser))
  end

  test "should show duser" do
    get :show, id: @duser
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @duser
    assert_response :success
  end

  test "should update duser" do
    patch :update, id: @duser, duser: { c_doulist: @duser.c_doulist, c_follower: @duser.c_follower, c_m_collect: @duser.c_m_collect, c_m_do: @duser.c_m_do, c_m_wish: @duser.c_m_wish, error: @duser.error, name: @duser.name, uid: @duser.uid }
    assert_redirected_to duser_path(assigns(:duser))
  end

  test "should destroy duser" do
    assert_difference('Duser.count', -1) do
      delete :destroy, id: @duser
    end

    assert_redirected_to dusers_path
  end
end
