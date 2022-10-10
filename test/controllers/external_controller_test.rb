# frozen_string_literal: true

require 'test_helper'

class ExternalControllerTest < ActionDispatch::IntegrationTest
  test 'should get about' do
    get external_about_url
    assert_response :success
  end

  test 'should get contact' do
    get external_contact_url
    assert_response :success
  end

  test 'should get events' do
    get external_events_url
    assert_response :success
  end

  test 'should get home' do
    get external_home_url
    assert_response :success
  end

  test 'should get login' do
    get external_login_url
    assert_response :success
  end
end
