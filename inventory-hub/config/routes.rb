Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  namespace :api do
    defaults format: :json do
      resources :inventory, only: [:create]
    end
  end 

  resources :inventories, only: [:index]
  resources :shoe_stores, only: [:show]
  resources :shoe_models, only: [:show]

  # Non existing routes should fallback to /inventories
  get '/' => redirect('/inventories')
  get "*path", to: redirect('/inventories')
end
