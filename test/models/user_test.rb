require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "atsushi", email: "atsushi@docomo.ne.jp", password: "password", password_confirmation: "password")
  end

  test "user valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.org"
    assert_not @user.valid?
  end

  test "valid email should be accepted" do
    valid_addresses = %w[asdfasfas@sdfsfs.sfsf sfsfas@sdfs.sfs.sfsdf]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be accepted"
    end
  end

  test "invalid email should be rejected" do
    invalid_addresses = %w[@sdfsfs.sdfsd asfsf asdfs@ sdfs@sadfs sdfs@sdf,sf sdfs@dsfa.]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address} should be rejected"
    end
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    duplicate_user.save
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = "    "
    assert_not @user.valid?
  end

  test "password should be enough long" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end
