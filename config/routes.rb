Rails.application.routes.draw do
  root "home#index"

  get "/sign-in" => "sessions#new"
  get "/wca-callback" => "sessions#create"
  delete "/sign-out" => "sessions#destroy"

  resources :competitions, only: [:new, :create, :index, :show]
  post "/competitions/:id/close-surveys" => "competitions#close_surveys", as: :competition_close_surveys
  resources :surveys, only: [:edit, :update, :index], param: :secret_id
end
