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

  put 'users/follow/:user_id' => 'users#follow'
  put 'users/unfollow/:user_id' => 'users#unfollow'
#フォローとフォローを外すアクション

get 'users/follow_list/:user_id' => 'users#follow_list'
get 'users/follower_list/:user_id' => 'users#follower_list'
#フォロー・フォロワーの一覧ページ
end
