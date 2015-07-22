require 'test_helper'

class DoulistsControllerTest < ActionController::TestCase
  setup do
    @doulist = doulists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:doulists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create doulist" do
    assert_difference('Doulist.count') do
      post :create, doulist: { dlist_id: @doulist.dlist_id, movie_id: @doulist.movie_id, name: @doulist.name, uname: @doulist.uname }
    end

    assert_redirected_to doulist_path(assigns(:doulist))
  end

  test "should show doulist" do
    get :show, id: @doulist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @doulist
    assert_response :success
  end

  test "should update doulist" do
    patch :update, id: @doulist, doulist: { dlist_id: @doulist.dlist_id, movie_id: @doulist.movie_id, name: @doulist.name, uname: @doulist.uname }
    assert_redirected_to doulist_path(assigns(:doulist))
  end

  test "should destroy doulist" do
    assert_difference('Doulist.count', -1) do
      delete :destroy, id: @doulist
    end

    assert_redirected_to doulists_path
  end
end
