Rails.application.routes.draw do
  get "/sign-in" => "sessions#new"
  get "/wca-callback" => "sessions#create"
  delete "/sign-out" => "sessions#destroy"
end
