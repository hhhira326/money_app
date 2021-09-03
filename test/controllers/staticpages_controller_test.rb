require 'test_helper'

class StaticpagesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get staticpages_top_url
    assert_response :success
  end

  test "should get about" do
    get staticpages_about_url
    assert_response :success
  end

end
