class IncomesController < ApplicationController
  def index
    @incomes = Income.all()

    render :index 
  end
end
