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
  get '/admin' => 'admin#index'
  get '/my-articles' => 'admin#my_articles'
  post '/follow-me' => 'admin#follow_user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
