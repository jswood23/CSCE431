require "test_helper"

class ExternalControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get external_home_url
    assert_response :success
  end

  test "should get events" do
    get external_events_url
    assert_response :success
  end

  test "should get about" do
    get external_about_url
    assert_response :success
  end

  test "should get contact" do
    get external_contact_url
    assert_response :success
  end

  test "should get nav_bar" do
    get external_nav_bar_url
    assert_response :success
  end
end
