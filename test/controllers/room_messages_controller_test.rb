require 'test_helper'

class RoomMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get room_messages_create_url
    assert_response :success
  end

  test "should get destroy" do
    get room_messages_destroy_url
    assert_response :success
  end
end
