require "./test/test_helper"

class UserTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::CreateUser.new(object: nil, field: nil, context: {}).resolve(**args)
  end

  test "create new user" do
    user = perform(
      name: "Test User",
      auth_provider: {
        credentials: {
          email: "email@example.com",
          password: "[omitted]"
        }
      }
    )

    assert user.persisted?
    assert_equal user.name, "Test User"
    assert_equal user.email, "email@example.com"

    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      assert_not user.valid?, "#{invalid_address.inspect} should be invalid"
    end

    assert_not user.authenticated?(:remember, "")
    user.microposts.create!(content: "Lorem ipsum")
    assert_difference "Micropost.count", -1 do
      user.destroy
    end

    michael = users(:michael)
    archer = users(:archer)
    lana = users(:lana)
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
    # Posts from followed user
    lana.microposts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    # Posts from self
    michael.microposts.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    # Posts from unfollowed user
    archer.microposts.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end
end
