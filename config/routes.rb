Rails.application.routes.draw do
  
  resources :admins
  resources :categories
  resources :sellers
  resources :customers
  
  resources :products do
    resources :reviews
  end

  
  devise_for :users, controllers: {registrations: 'registrations'}
  root to: "home#index"

   get "/users", to: "admins#users", as: "users"
  delete "/users/:id", to: "admins#admin_delete_user", as: "admin_delete_user"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
