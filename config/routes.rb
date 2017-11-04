Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root to: 'home#index'
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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
