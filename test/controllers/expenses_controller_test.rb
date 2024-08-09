require "test_helper"

class ExpensesControllerTest < ActionDispatch::IntegrationTest
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
    get "/expenses.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Expense.count, data.length
  end

  test "create" do
    assert_difference "Expense.count", 1 do
      post "/expenses.json", params: {
        user_id: @user.id,
        amount: 51.00,
        category: "bills",
        date: "1984-02-22"
      }, headers: {
        "Authorization" => "Bearer #{@jwt}"
      }
      assert_response 200
    end
  end

  test "show" do
    get "/expenses/#{Expense.first.id}.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "amount", "category", "date", "user_id"], data.keys
  end

  test "update" do
    expense = Expense.first
    patch "/expenses/#{expense.id}.json", params: {
      expense: { amount: 52.0 }
    }, as: :json
    assert_response :success

    data = JSON.parse(response.body)
    assert_equal 52.0, data["amount"].to_f
  end
end
