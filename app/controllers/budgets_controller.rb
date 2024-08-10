class BudgetsController < ApplicationController
  def index
    @budgets = Budget.all
    render :index
  end

  def create
    @budget = Budget.new(budget_params.merge(user_id: current_user.id))
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
