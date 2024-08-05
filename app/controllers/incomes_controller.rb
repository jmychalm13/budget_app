class IncomesController < ApplicationController
  def index
    @incomes = Income.all()

    render :index 
  end

  def create
    @income = Income.new(income_params.merge(user_id: current_user.id))

    if @income.save
      render :show
    else
      render json: @income.errors, status: :unprocessable_entity
    end
  end

  def income_params
    params.permit(:amount, :source, :date)
  end
end
