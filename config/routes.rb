Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :relationships, only: [:create, :destroy]

  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end



  # run with rake routes to create posts routes
  # gives 7 restful routes
  resources :posts

  root to: "home#index"
end
