Rails.application.routes.draw do
  devise_for :users
  get 'comments/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[index new create destroy]
      resources :likes, only: [:create]
    end
  end

  # resources :posts, only: [:show]
  root 'users#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
