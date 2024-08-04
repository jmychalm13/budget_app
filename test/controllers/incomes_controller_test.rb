require "test_helper"

class IncomesControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/incomes.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Income.count, data.length
  end
end
