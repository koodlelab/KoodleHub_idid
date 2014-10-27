require 'test_helper'

class UserUpdateTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:koodlenoodle)
  end

  test "failed user update" do
    log_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), user: { name: '',
                                    email: 'xxx',
                                    password: '',
                                    password_confirmation: 'b'}
    assert_template 'users/edit'
  end

  test "successful user update" do
    get edit_user_path(@user)
    assert_equal session[:forwarding_url], edit_user_url(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    assert_nil session[:forwarding_url]
    name = "koodo noodle"
    email = "jing@koodolab.com"
    patch user_path(@user), user: { name: name,
                                    email: email,
                                    password: 'temp123',
                                    password_confirmation: 'temp123'}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end
end
