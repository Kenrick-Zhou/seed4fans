require 'test_helper'

class MovieTagsControllerTest < ActionController::TestCase
  setup do
    @movie_tag = movie_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_tag" do
    assert_difference('MovieTag.count') do
      post :create, movie_tag: { movie_id: @movie_tag.movie_id, name: @movie_tag.name, tag_id: @movie_tag.tag_id }
    end

    assert_redirected_to movie_tag_path(assigns(:movie_tag))
  end

  test "should show movie_tag" do
    get :show, id: @movie_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie_tag
    assert_response :success
  end

  test "should update movie_tag" do
    patch :update, id: @movie_tag, movie_tag: { movie_id: @movie_tag.movie_id, name: @movie_tag.name, tag_id: @movie_tag.tag_id }
    assert_redirected_to movie_tag_path(assigns(:movie_tag))
  end

  test "should destroy movie_tag" do
    assert_difference('MovieTag.count', -1) do
      delete :destroy, id: @movie_tag
    end

    assert_redirected_to movie_tags_path
  end
end
