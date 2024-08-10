class ExpensesController < ApplicationController
  def index
    @expenses = Expense.all
    render :index
  end

  def create
    @expense = Expense.new(expense_params.merge(user_id: current_user.id))

    if @expense.save
      render :show, status: :created
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
    # @expense = Expense.create(
    #   user_id: current_user.id,
    #   amount: params[:amount],
    #   category: params[:category],
    #   date: params[:date]
    # )
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

  def destroy
    @expense = Expense.find_by(id: params[:id])
    @expense.destroy
    render json: { message: "Expense destroyed successfully" }
  end

  private

  def expense_params
    params.permit(:amount, :category, :date)
  end
end