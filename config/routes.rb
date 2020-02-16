Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users
  resources :contents do
    resource :comments, only: [:create, :destroy]
  end #この記事のみにコメント機能を搭載する
end
