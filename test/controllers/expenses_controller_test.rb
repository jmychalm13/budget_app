require "test_helper"

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/expenses.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Expense.count, data.length
  end
end
