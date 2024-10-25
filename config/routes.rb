Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # Route for fetching the price of a specific stock
  get 'stocks/price', to: 'stocks#price', constraints: { symbol: /[^\/]+/ }

  # Route for fetching the prices of multiple stocks
  get 'stocks/prices', to: 'stocks#prices'

  # Route for fetching all stock prices
  get 'stocks/price_all', to: 'stocks#price_all'
  
  # Add a custom route for resetting data
  delete '/reset', to: 'reset#destroy'
  # Wallets routes
  resources :wallets, only: [:create, :show, :index] do
    member do
      get :balance  # Retrieve current wallet balance
    end
  end

  # Transactions routes
  resources :transactions, only: [:create, :index]  # Create transactions and view history
end
