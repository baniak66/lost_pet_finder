Rails.application.routes.draw do
  devise_for :users
  root 'announcements#index'
  resources :announcements
end
