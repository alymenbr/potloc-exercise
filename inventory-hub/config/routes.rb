Rails.application.routes.draw do
  resources :tests
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Swaggard Engine
  mount Swaggard::Engine, at: '/api_docs/swagger/'

  # External api path - only json
  namespace :api do
    defaults format: :json do
      resources :inventory, only: [:create]
    end
  end 

  # Common api path - json and html
  resources :inventories, only: [:index]
  resources :shoe_stores, only: [:show]
  resources :shoe_models, only: [:show] do
    collection do
      get "suggestion"
    end    
  end

  # Non existing routes should fallback to /inventories
  get '/' => redirect('/inventories')
  get "*path", to: redirect('/inventories')
end
