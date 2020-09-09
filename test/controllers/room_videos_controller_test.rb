require 'test_helper'

class RoomVideosControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get room_videos_create_url
    assert_response :success
  end

  test "should get destroy" do
    get room_videos_destroy_url
    assert_response :success
  end

end
