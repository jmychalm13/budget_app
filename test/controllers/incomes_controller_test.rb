require "test_helper"

class IncomesControllerTest < ActionDispatch::IntegrationTest
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
    get "/incomes.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Income.count, data.length
  end

  test "create" do
    assert_difference "Income.count", 1 do
      post "/incomes.json", params: {
        amount: 12.50,
        source: "work",
        date: "2024-02-22",
      }, headers: {
        "Authorization" => "Bearer #{@jwt}"
      }
      assert_response 200
    end
  end

  test "show" do
    get "/incomes/#{Income.first.id}.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "amount", "source", "date"], data.keys
  end

  test "update" do
    income = Income.first
    patch "/incomes/#{income.id}.json", params: {
      amount: 14.00
    }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal "14.0", data["amount"]
  end
end
