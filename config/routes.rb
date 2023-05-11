Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :items
  resources :lots, only: [:show, :new, :create, :edit, :update]
end
