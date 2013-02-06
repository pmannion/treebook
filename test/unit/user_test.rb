require 'test_helper'

class UserTest < ActiveSupport::TestCase
 test "a user should enter a first name" do
   user = User.new
   assert !user.save
   assert !user.errors[:first_name].empty?
 end

  test "a user should enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
    user = User.new
    user.profile_name  = users(:paul).profile_name

    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
    user = User.new(first_name:"paul", last_name: "mannion", email:"mannion.paul1@gmail.com")
    user.password = user.password_confirmation = "asdfgw"

    user.profile_name = "my profile with spaces"
    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("must be formatted correctly")
  end

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name:"paul", last_name: "mannion", email:"mannion.paul1@gmail.com")
    user.password = user.password_confirmation = "asdfgw"

    user.profile_name = 'paulmannion_1'
    assert user.valid?
  end

end
