class IncomesController < ApplicationController
  def index
    @incomes = Income.all()

    render :index 
  end

  def create
    pp current_user
    @income = Income.new(income_params.merge(user_id: current_user.id))

    if @income.save
      render :show
    else
      render json: @income.errors, status: :unprocessable_entity
    end
  end

  def show
    @income = Income.find_by(id: params[:id])
    render :show
  end

  def update
    @income = Income.find_by(id: params[:id])
    @income.update(
      amount: params[:amount] || @income.amount,
      source: params[:source] || @income.source,
      date: params[:date] || @income.date,
    )    
    render :show
  end

  def destroy
    @income = Income.find_by(id: params[:id])
    @income.destroy
    render json: { message: "Income destroyed successfully" }
  end

  def income_params
    params.permit(:amount, :source, :date)
  end
end
