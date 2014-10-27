require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:koodlenoodle)
    @other_user = users(:koodonoodle)
  end
  test "should get new" do
    get :new
    assert_response :success
  end

  test "unauthorized users view without login session" do
    get :index
    assert_redirected_to login_url
  end

  test "unauthorized edit without login session" do
    get :edit, id:@user
    assert_redirected_to login_url
  end

  test "unauthorized update without login session" do
    get :update, id:@user, user: {name:"koodonoodle"}
    assert_redirected_to login_url
  end

  test "unauthorized edit without valid login session" do
    log_in_as(@other_user)
    get :edit, id:@user
    assert_redirected_to root_url
  end

  test "unauthorized update without valid login session" do
    log_in_as(@other_user)
    get :update, id:@user, user: {name:"koodonoodle"}
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

end
