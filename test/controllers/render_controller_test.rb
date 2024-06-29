require "./test/test_helper"

class RenderControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_path
    assert_response :success
  end
end
