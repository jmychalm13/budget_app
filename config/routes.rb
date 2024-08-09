Rails.application.routes.draw do
  post "/users" => "users#create"

  post "/sessions" => "sessions#create"

  resources :incomes

  resources :expenses

  resources :budgets
end
