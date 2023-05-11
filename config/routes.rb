Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :items, only: [:index, :show]
  resources :lots, only: [:show] # (lots#index => home#index) lots_path => root_path

  namespace :admin do
    resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :lots, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end
