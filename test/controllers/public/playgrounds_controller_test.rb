require "test_helper"

class Public::PlaygroundsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_playgrounds_new_url
    assert_response :success
  end

  test "should get index" do
    get public_playgrounds_index_url
    assert_response :success
  end

  test "should get show" do
    get public_playgrounds_show_url
    assert_response :success
  end

  test "should get create" do
    get public_playgrounds_create_url
    assert_response :success
  end

  test "should get edit" do
    get public_playgrounds_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_playgrounds_update_url
    assert_response :success
  end

  test "should get destroy" do
    get public_playgrounds_destroy_url
    assert_response :success
  end
end
