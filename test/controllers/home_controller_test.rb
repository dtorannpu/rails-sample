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

  test "should redirect when not authenticated" do
    get home_index_url
    assert_redirected_to new_session_url
  end
end
