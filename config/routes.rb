Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'announcements#index'
  resources :announcements do
      resources :messages, only: [:create]
      get 'users', on: :collection
      post 'close', on: :member
  end
end
