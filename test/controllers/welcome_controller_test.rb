require "test_helper"

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get welcome_index_url
    assert_response :success
  end

  test "should get signin" do
    get welcome_signin_url
    assert_response :success
  end

  test "should get signup" do
    get welcome_signup_url
    assert_response :success
  end

  test "should get reset_password" do
    get welcome_reset_password_url
    assert_response :success
  end

  test "should get forgot_password" do
    get welcome_forgot_password_url
    assert_response :success
  end
end
