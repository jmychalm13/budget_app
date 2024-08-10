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

  test "create" do
    assert_difference "Budget.count", 1 do
      post "/budgets.json", params: {
        "category": "fun money",
        "amount": 500.00,
        "start_date": "2024-08-01",
        "end_date": "2024-10-01",
        "user_id": @user.id
      }, headers: {
        "Authorization" => "Bearer #{@jwt}"
      }
      assert_response :success
    end
  end

  test "show" do
    get "/budgets/#{Budget.first.id}.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "user_id", "category", "amount", "start_date", "end_date"], data.keys
  end

  test "update" do
    @budget = Budget.first
    patch "/budgets/#{@budget.id}.json", params: {
      "category": "bills"
    }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal "bills", data["category"]
  end
end

