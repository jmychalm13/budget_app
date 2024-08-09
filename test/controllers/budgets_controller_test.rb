require "test_helper"

class BudgetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(
      name: "Jane",
      email: "jane@test.com",
      password: "password",
      password_confirmation: "password"
    )
    post "/sessions.json", params: {email: "jane@test.com", password: "password"}
    data = JSON.parse(response.body)
    @jwt = data["jwt"]
  end

  test "index" do
    get "/budgets.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Budget.count, data.length
  end
end
