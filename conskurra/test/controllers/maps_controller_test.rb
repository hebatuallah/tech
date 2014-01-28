require 'test_helper'

class MapsControllerTest < ActionController::TestCase
  setup do
    @map = maps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:maps)
  end
    assert_redirected_to maps_path
  end
end
