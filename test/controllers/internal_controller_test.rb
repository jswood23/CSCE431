require "test_helper"

class InternalControllerTest < ActionDispatch::IntegrationTest
  test "should get attend" do
    get internal_attend_url
    assert_response :success
  end

  test "should get members" do
    get internal_members_url
    assert_response :success
  end

  test "should get profile" do
    get internal_profile_url
    assert_response :success
  end
end
