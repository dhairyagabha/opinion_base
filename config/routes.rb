Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root to: 'home#index'
  devise_for :users
  resources :articles do
    collection do
      get :search
      post :search
      get '/author/:username' => 'articles#author', as: 'author'
    end
    member do
      post :interaction
    end
  end
  resources :comments
  resources :tags
  get '/admin' => 'admin#index'
  get '/my-articles' => 'admin#my_articles'
  post '/follow-me' => 'admin#follow_user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
