require 'test_helper'

class CogsControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get cogs_list_url
    assert_response :success
  end

end
