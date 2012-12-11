require 'test_helper'

class ContentControllerTest < ActionController::TestCase
  test "should get silver" do
    get :silver
    assert_response :success
  end

  test "should get gold" do
    get :gold
    assert_response :success
  end

  test "should get platinum" do
    get :platinum
    assert_response :success
  end

end
