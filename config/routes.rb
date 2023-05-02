Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  root "home#index"
  devise_for :users
  namespace :api do
    namespace :v1 do

      resources :user , only: [:create, :destroy, :index] do
        resources :group, only: [:create, :index]
      end
      resources :session, only: [:create, :destroy]
      resources :posts
      #friend_request_routes
      get "/friend_requests", to: "friend_request#index"
      post "/friend_request", to: "friend_request#create"
      patch "/accept_friend_request", to: "friend_request#accept_request"
      patch "/reject_friend_request", to: "friend_request#reject_request"
      get "/get_feed", to: "feed#index"
    end
  end

end
