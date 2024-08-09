class BudgetsController < ApplicationController
  def index
    @budgets = Budget.all
    render :index
  end
end
