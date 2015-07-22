require 'test_helper'

class HotCommentsControllerTest < ActionController::TestCase
  setup do
    @hot_comment = hot_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hot_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hot_comment" do
    assert_difference('HotComment.count') do
      post :create, hot_comment: { comment: @hot_comment.comment, did: @hot_comment.did, movie_id: @hot_comment.movie_id, name: @hot_comment.name, pubdate: @hot_comment.pubdate, rating: @hot_comment.rating }
    end

    assert_redirected_to hot_comment_path(assigns(:hot_comment))
  end

  test "should show hot_comment" do
    get :show, id: @hot_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hot_comment
    assert_response :success
  end

  test "should update hot_comment" do
    patch :update, id: @hot_comment, hot_comment: { comment: @hot_comment.comment, did: @hot_comment.did, movie_id: @hot_comment.movie_id, name: @hot_comment.name, pubdate: @hot_comment.pubdate, rating: @hot_comment.rating }
    assert_redirected_to hot_comment_path(assigns(:hot_comment))
  end

  test "should destroy hot_comment" do
    assert_difference('HotComment.count', -1) do
      delete :destroy, id: @hot_comment
    end

    assert_redirected_to hot_comments_path
  end
end
