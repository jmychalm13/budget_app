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

  def show
    @expense = Expense.find_by(id: params[:id])
    render :show
  end

  def update
    @expense = Expense.find_by(id: params[:id])
    if @expense.nil?
      render json: { error: "Expense not found" }, status: :not_found
      return
    end

    if @expense.update(expense_params)
      render json: @expense, status: :ok
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:amount, :category, :date)
  end
end