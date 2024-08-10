class BudgetsController < ApplicationController
  def index
    @budgets = Budget.all
    render :index
  end

  def create
    @budget = Budget.create(
      user_id: current_user.id,
      amount: params[:amount],
      category: params[:category],
      start_date: params[:start_date],
      end_date: params[:end_date] 
    )
    if @budget.save
      render json: @budget, status: :created
    else
      render json: @budget.errors, status: :unprocessable_entity
    end
  end

  def show
    @budget = Budget.find_by(id: params[:id])
    render :show
  end

  def update
    @budget = Budget.find(params[:id])
    if @budget.update(budget_params)
      render :show, status: :ok
    else
      render json: @budget.errors, status: :unprocessable_entity
    end
  end

  private

  def budget_params
    params.permit(:amount, :category, :start_date, :end_date)
  end
end
