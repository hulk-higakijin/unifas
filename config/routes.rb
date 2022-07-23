Rails.application.routes.draw do
  root to: "home#index"
  devise_for :accounts
  resources :recruitments
end
