require 'test_helper'

class MovieLanguagesControllerTest < ActionController::TestCase
  setup do
    @movie_language = movie_languages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_languages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_language" do
    assert_difference('MovieLanguage.count') do
      post :create, movie_language: { language_id: @movie_language.language_id, movie_id: @movie_language.movie_id, name: @movie_language.name }
    end

    assert_redirected_to movie_language_path(assigns(:movie_language))
  end

  test "should show movie_language" do
    get :show, id: @movie_language
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie_language
    assert_response :success
  end

  test "should update movie_language" do
    patch :update, id: @movie_language, movie_language: { language_id: @movie_language.language_id, movie_id: @movie_language.movie_id, name: @movie_language.name }
    assert_redirected_to movie_language_path(assigns(:movie_language))
  end

  test "should destroy movie_language" do
    assert_difference('MovieLanguage.count', -1) do
      delete :destroy, id: @movie_language
    end

    assert_redirected_to movie_languages_path
  end
end
