class ExpensesController < ApplicationController
  def index
    @expenses = Expense.all
    render :index
  end
end
