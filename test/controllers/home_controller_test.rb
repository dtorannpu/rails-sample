require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
  end

  test "should get index" do
    sign_in(@user)

    get home_index_url
    assert_response :success
  end

  test "should show sign out button only when authenticated" do
    get new_session_url
    assert_select "button", text: "Sign out", count: 0

    sign_in(@user)
    get home_index_url
    assert_select "button", text: "Sign out", count: 1
  end

  test "should sign out" do
    sign_in(@user)

    assert_difference "Session.count", -1 do
      delete session_url
    end
    assert_redirected_to new_session_url

    get home_index_url
    assert_redirected_to new_session_url
  end

  test "should redirect when not authenticated" do
    get home_index_url
    assert_redirected_to new_session_url
  end
end
