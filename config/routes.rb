Rails.application.routes.draw do
  root to: 'home#index'
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  resources :articles
  resources :comments
end
