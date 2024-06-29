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
  end
end
