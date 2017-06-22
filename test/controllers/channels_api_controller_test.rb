require 'test_helper'

class CoursesApiControllerTest < ActionDispatch::IntegrationTest

  test "Get index" do
    get channels_index_api_url
    assert_response :success
  end
  test "Get show" do
    get channels_show_api_url(1)
    assert_response :success
  end

end
