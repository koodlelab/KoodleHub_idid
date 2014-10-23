require 'test_helper'

class SignonTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signon" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {name: " ", email:" ", password:" ", password_confirmation:" "}
    end
    assert_template 'users/new'
  end

  test "valid signon" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: {name: "koodle noodle", email:"koodlela@koodlelab.com",
                              password:"temp1234", password_confirmation:"temp1234"}
    end
    assert_template 'users/show'
  end

end
