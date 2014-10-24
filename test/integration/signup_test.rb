require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {name: " ", email:" ", password:" ", password_confirmation:" "}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
    assert_select 'li'
    assert_not_nil flash
  end


  test "valid signup" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {name: "koodle noodle", email:"koodlela@koodlelab.com",
                              password:"temp1234", password_confirmation:"temp1234"}
    end
    assert_template 'users/show'
    assert is_logged_in?
    # assert flash.equal?(:success)
    assert_not_nil flash
  end




end
