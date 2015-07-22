require 'test_helper'

class NewCommentsControllerTest < ActionController::TestCase
  setup do
    @new_comment = new_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:new_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create new_comment" do
    assert_difference('NewComment.count') do
      post :create, new_comment: { comment: @new_comment.comment, did: @new_comment.did, movie_id: @new_comment.movie_id, name: @new_comment.name, pubdate: @new_comment.pubdate, rating: @new_comment.rating }
    end

    assert_redirected_to new_comment_path(assigns(:new_comment))
  end

  test "should show new_comment" do
    get :show, id: @new_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @new_comment
    assert_response :success
  end

  test "should update new_comment" do
    patch :update, id: @new_comment, new_comment: { comment: @new_comment.comment, did: @new_comment.did, movie_id: @new_comment.movie_id, name: @new_comment.name, pubdate: @new_comment.pubdate, rating: @new_comment.rating }
    assert_redirected_to new_comment_path(assigns(:new_comment))
  end

  test "should destroy new_comment" do
    assert_difference('NewComment.count', -1) do
      delete :destroy, id: @new_comment
    end

    assert_redirected_to new_comments_path
  end
end
