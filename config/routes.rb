Rails.application.routes.draw do
  # routes for the home controller
  get 'home/index'

# routes for the payments controller
  get 'payments/success'
  get 'payments/fail'
  get 'payments/transations'
  get 'payments/operations'

#routes for the users controller
  get 'users/gerencial'
  put 'users/:id/inactive', to: 'users#destroy', as: 'inactivate_user'
  put 'users/:id/active', to: 'users#active', as: 'activate_user'

  devise_for :users
  resources :users

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"
  post 'process_payment', to: 'payments#process_payment'

  resources :users
  resources :payments
  resources :home
end
