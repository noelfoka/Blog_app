Rails.application.routes.draw do
  devise_for :users
  get 'comments/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create]do
    resources :comments ,only:[:index,:new,:create]
    resources :likes ,only:[:create]
    end
  end

  # resources :posts, only: [:show]
  root 'users#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
