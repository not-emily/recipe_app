Rails.application.routes.draw do
  root 'recipes#index'

  # Recipes
  resources :recipes

  # Welcome
  get '/signin', to: 'welcome#signin', as: :signin
  post '/signin', to: 'welcome#signin_do', as: :do_signin
  get '/signup', to: 'welcome#signup', as: :signup
  post '/signup', to: 'welcome#signup_do', as: :do_signup
  get '/signout', to: 'welcome#signout', as: :signout
  post '/auth/gsi/callback', to: 'welcome#gsi', as: :gsi
  get '/auth/gsi/session/:user_apikey', to: 'welcome#gsi_session', as: :gsi_session
  get '/reset-password', to: 'welcome#reset_password', as: :reset_password
  get '/forgot-password', to: 'welcome#forgot_password', as: :forgot_password

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
