require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  setup do
    @movie = movies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie" do
    assert_difference('Movie.count') do
      post :create, movie: { cn_title: @movie.cn_title, duration: @movie.duration, e_count: @movie.e_count, e_duration: @movie.e_duration, imdb_id: @movie.imdb_id, original_title: @movie.original_title, poster_id: @movie.poster_id, poster_url: @movie.poster_url, pubyear: @movie.pubyear, rating: @movie.rating, subtype: @movie.subtype, summary: @movie.summary, title: @movie.title }
    end

    assert_redirected_to movie_path(assigns(:movie))
  end

  test "should show movie" do
    get :show, id: @movie
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie
    assert_response :success
  end

  test "should update movie" do
    patch :update, id: @movie, movie: { cn_title: @movie.cn_title, duration: @movie.duration, e_count: @movie.e_count, e_duration: @movie.e_duration, imdb_id: @movie.imdb_id, original_title: @movie.original_title, poster_id: @movie.poster_id, poster_url: @movie.poster_url, pubyear: @movie.pubyear, rating: @movie.rating, subtype: @movie.subtype, summary: @movie.summary, title: @movie.title }
    assert_redirected_to movie_path(assigns(:movie))
  end

  test "should destroy movie" do
    assert_difference('Movie.count', -1) do
      delete :destroy, id: @movie
    end

    assert_redirected_to movies_path
  end
end
