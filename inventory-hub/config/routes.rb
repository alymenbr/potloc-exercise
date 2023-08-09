Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    defaults format: :json do
      resources :inventory, only: [:create]
    end
  end 

  resources :inventories, only: [:index]
end
