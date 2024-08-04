Rails.application.routes.draw do
  post "/users" => "users#create"

  post "/sessions" => "sessions#create"

  resources :incomes, only: [:index, :show, :create, :update, :destroy]
end
