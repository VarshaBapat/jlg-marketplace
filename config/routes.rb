Rails.application.routes.draw do
  
  resources :admins
  resources :categories
  resources :sellers
  resources :customers
  resources :reviews
  resources :comments
  resources :products
  resources :orders
  devise_for :users, controllers: {registrations: 'registrations'}
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
