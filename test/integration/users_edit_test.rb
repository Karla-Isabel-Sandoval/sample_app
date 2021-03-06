
require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @admin  = users(:one)
    @non_admin = users(:archer)
    @user = users(:one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                                              email: "foo@invalid",
                                              password: "foo",
                                              password_confirmation: "bar"}}
    assert_template 'users/edit'
    assert_select "div.alert", "The form contains 5 errors"
  end

  test "successful edit with friendly forwarding" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: '',
                                              password_confirmation: ''
                                              } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end

#assert_not_nil session[:forwarding_url]
#assert_redirected_to edit_user_path(@user)
# figure out why lines 23 & 25 are syntactically structured the way they are?
