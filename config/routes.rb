Rails.application.routes.draw do
  root "home#index"

  get "/sign-in" => "sessions#new"
  get "/wca-callback" => "sessions#create"
  delete "/sign-out" => "sessions#destroy"

  resources :competitions, only: [:new, :create, :index, :show]
end
