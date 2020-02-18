Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users
  resources :contents do
    resource :favorites, only: [:create, :destroy]
    resource :comments, only: [:create, :destroy]
    get :search, on: :collection
  end #この記事のみにコメント機能を搭載する

  resources :users do
    get :search, on: :collection
  end
end
