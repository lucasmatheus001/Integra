Rails.application.routes.draw do
  get 'home/index'
  get 'payments/success'
  get 'payments/fail'

  devise_for :users
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"
  post 'process_payment', to: 'payments#process_payment'

  resources :users
  resources :payments
  resources :home
  # Defines the root path route ("/")
  # root "posts#index"
end
