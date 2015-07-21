require 'test_helper'

class MovieTypesControllerTest < ActionController::TestCase
  setup do
    @movie_type = movie_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_type" do
    assert_difference('MovieType.count') do
      post :create, movie_type: { movie_id: @movie_type.movie_id, name: @movie_type.name, type_id: @movie_type.type_id }
    end

    assert_redirected_to movie_type_path(assigns(:movie_type))
  end

  test "should show movie_type" do
    get :show, id: @movie_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie_type
    assert_response :success
  end

  test "should update movie_type" do
    patch :update, id: @movie_type, movie_type: { movie_id: @movie_type.movie_id, name: @movie_type.name, type_id: @movie_type.type_id }
    assert_redirected_to movie_type_path(assigns(:movie_type))
  end

  test "should destroy movie_type" do
    assert_difference('MovieType.count', -1) do
      delete :destroy, id: @movie_type
    end

    assert_redirected_to movie_types_path
  end
end
