Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  root "home#index"
  devise_for :users
  namespace :api do
    namespace :v1 do

      resources :user , only: [:create]
      resources :session, only: [:create, :destroy]
      resources :posts
    end
  end

end
