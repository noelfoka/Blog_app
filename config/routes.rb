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
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts, only: [:index] do
         resources :comments, only: [:index, :create]
        end
      end
    end
  end
end