Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :items, only: [:index, :show]
  resources :lots, only: [:show] do
    resources :bids, only: [:create]
  end

  resources :dashboards, only: [:index]
  resources :favorites, only: [:create, :destroy]
  namespace :admin do
    resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :lots, only: [:index, :new, :create, :edit, :update, :destroy]
    post '/lots/:id/add_item', to: 'lots#add_item', as: :add_item_to_lot
    post '/lots/:id/remove_item', to: 'lots#remove_item', as: :remove_item_from_lot
    patch '/lots/:id/approve', to: 'lots#approve', as: :approve_lot
    patch '/lots/:id/cancel', to: 'lots#cancel', as: :cancel_lot
    patch '/lots/:id/sell', to: 'lots#sell', as: :sell_lot
    get 'dashboard', to: 'dashboards#index', as: :dashboard
    get 'items/lotless', to: 'items#lotless_items', as: :lotless_items
    get 'items/sold', to: 'items#sold_items', as: :sold_items
    resources :blocked_cpfs, only: [:index, :new, :create, :edit, :update, :destroy]

  end
end
