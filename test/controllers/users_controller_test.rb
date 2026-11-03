require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user and sign in" do
    assert_difference [ "User.count", "Session.count" ], 1 do
      post users_url, params: { user: { email_address: "New@Example.com", password: "password123", password_confirmation: "password123" } }
    end

    assert_redirected_to root_url
    assert_equal "new@example.com", User.last.email_address
  end

  test "should not create user with mismatched password confirmation" do
    assert_no_difference "User.count" do
      post users_url, params: { user: { email_address: "new@example.com", password: "password123", password_confirmation: "different" } }
    end

    assert_response :unprocessable_entity
  end

  test "should not create user with duplicate email" do
    existing = create(:user)

    assert_no_difference "User.count" do
      post users_url, params: { user: { email_address: existing.email_address, password: "password123", password_confirmation: "password123" } }
    end

    assert_response :unprocessable_entity
  end
end
