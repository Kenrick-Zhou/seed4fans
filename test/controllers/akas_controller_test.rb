require 'test_helper'

class AkasControllerTest < ActionController::TestCase
  setup do
    @aka = akas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:akas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create aka" do
    assert_difference('Aka.count') do
      post :create, aka: { aka: @aka.aka, movie_id: @aka.movie_id }
    end

    assert_redirected_to aka_path(assigns(:aka))
  end

  test "should show aka" do
    get :show, id: @aka
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @aka
    assert_response :success
  end

  test "should update aka" do
    patch :update, id: @aka, aka: { aka: @aka.aka, movie_id: @aka.movie_id }
    assert_redirected_to aka_path(assigns(:aka))
  end

  test "should destroy aka" do
    assert_difference('Aka.count', -1) do
      delete :destroy, id: @aka
    end

    assert_redirected_to akas_path
  end
end
