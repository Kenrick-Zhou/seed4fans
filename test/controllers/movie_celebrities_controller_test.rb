require 'test_helper'

class MovieCelebritiesControllerTest < ActionController::TestCase
  setup do
    @movie_celebrity = movie_celebrities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_celebrities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_celebrity" do
    assert_difference('MovieCelebrity.count') do
      post :create, movie_celebrity: { celebrity_id: @movie_celebrity.celebrity_id, movie_id: @movie_celebrity.movie_id, name: @movie_celebrity.name, role: @movie_celebrity.role }
    end

    assert_redirected_to movie_celebrity_path(assigns(:movie_celebrity))
  end

  test "should show movie_celebrity" do
    get :show, id: @movie_celebrity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie_celebrity
    assert_response :success
  end

  test "should update movie_celebrity" do
    patch :update, id: @movie_celebrity, movie_celebrity: { celebrity_id: @movie_celebrity.celebrity_id, movie_id: @movie_celebrity.movie_id, name: @movie_celebrity.name, role: @movie_celebrity.role }
    assert_redirected_to movie_celebrity_path(assigns(:movie_celebrity))
  end

  test "should destroy movie_celebrity" do
    assert_difference('MovieCelebrity.count', -1) do
      delete :destroy, id: @movie_celebrity
    end

    assert_redirected_to movie_celebrities_path
  end
end
