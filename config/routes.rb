Rails.application.routes.draw do
  devise_for :users
  root 'announcements#index'
  resources :announcements do
      get 'users', on: :collection
      post 'close', on: :member
  end
end
