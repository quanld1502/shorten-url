Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "links#index"
  resources :links

  namespace :api do
    post :login, to: 'authentication#login'
  end
end
