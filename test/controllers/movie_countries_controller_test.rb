require 'test_helper'

class MovieCountriesControllerTest < ActionController::TestCase
  setup do
    @movie_country = movie_countries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_countries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_country" do
    assert_difference('MovieCountry.count') do
      post :create, movie_country: { country_id: @movie_country.country_id, movie_id: @movie_country.movie_id, name: @movie_country.name }
    end

    assert_redirected_to movie_country_path(assigns(:movie_country))
  end

  test "should show movie_country" do
    get :show, id: @movie_country
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie_country
    assert_response :success
  end

  test "should update movie_country" do
    patch :update, id: @movie_country, movie_country: { country_id: @movie_country.country_id, movie_id: @movie_country.movie_id, name: @movie_country.name }
    assert_redirected_to movie_country_path(assigns(:movie_country))
  end

  test "should destroy movie_country" do
    assert_difference('MovieCountry.count', -1) do
      delete :destroy, id: @movie_country
    end

    assert_redirected_to movie_countries_path
  end
end
