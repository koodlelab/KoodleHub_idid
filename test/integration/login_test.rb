require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:koodlenoodle)
  end

  test "valid login followed by logout" do
    get login_path
    assert_template 'sessions/new'
    post login_path, user_session: { email: @user.email, password: 'temp123' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "invalid login" do
    get login_path
    assert_template 'sessions/new'
    post login_path, user_session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with remember me checked" do
    log_in_as(@user, remember_me: '1')
    assert is_logged_in?
    assert_equal assigns(:user).remember_token, cookies['remember_token']
  end

  test "login with remember me unchecked" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end

end
