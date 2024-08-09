class ExpensesController < ApplicationController
  def index
    @expenses = Expense.all
    render :index
  end

  def create
    @expense = Expense.create(
      user_id: current_user.id,
      amount: params[:amount],
      category: params[:category],
      date: params[:date]
    )
    render :show
  end
end