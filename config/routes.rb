Rails.application.routes.draw do
  root to: 'home#index'
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  resources :articles do
    collection do
      get :search
      post :search
    end
    member do
      post :interaction
    end
  end
  resources :comments
end
