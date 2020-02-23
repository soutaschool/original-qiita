# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                      root GET    /                                                                                        homes#top
#          new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
#              user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
#      destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
#         new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#        edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#             user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                           PUT    /users/password(.:format)                                                                devise/passwords#update
#                           POST   /users/password(.:format)                                                                devise/passwords#create
#  cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
#     new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
#    edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
#         user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
#                           PUT    /users(.:format)                                                                         devise/registrations#update
#                           DELETE /users(.:format)                                                                         devise/registrations#destroy
#                           POST   /users(.:format)                                                                         devise/registrations#create
#         content_favorites DELETE /contents/:content_id/favorites(.:format)                                                favorites#destroy
#                           POST   /contents/:content_id/favorites(.:format)                                                favorites#create
#          content_comments DELETE /contents/:content_id/comments(.:format)                                                 comments#destroy
#                           POST   /contents/:content_id/comments(.:format)                                                 comments#create
#          timeline_content GET    /contents/:id/timeline(.:format)                                                         contents#timeline
#           search_contents GET    /contents/search(.:format)                                                               contents#search
#           confirm_content GET    /contents/:id/confirm(.:format)                                                          contents#confirm
#                  contents GET    /contents(.:format)                                                                      contents#index
#                           POST   /contents(.:format)                                                                      contents#create
#               new_content GET    /contents/new(.:format)                                                                  contents#new
#              edit_content GET    /contents/:id/edit(.:format)                                                             contents#edit
#                   content GET    /contents/:id(.:format)                                                                  contents#show
#                           PATCH  /contents/:id(.:format)                                                                  contents#update
#                           PUT    /contents/:id(.:format)                                                                  contents#update
#                           DELETE /contents/:id(.:format)                                                                  contents#destroy
#              search_users GET    /users/search(.:format)                                                                  users#search
#                     users GET    /users(.:format)                                                                         users#index
#                           POST   /users(.:format)                                                                         users#create
#                  new_user GET    /users/new(.:format)                                                                     users#new
#                 edit_user GET    /users/:id/edit(.:format)                                                                users#edit
#                      user GET    /users/:id(.:format)                                                                     users#show
#                           PATCH  /users/:id(.:format)                                                                     users#update
#                           PUT    /users/:id(.:format)                                                                     users#update
#                           DELETE /users/:id(.:format)                                                                     users#destroy
#                           PUT    /users/follow/:user_id(.:format)                                                         users#follow
#                           PUT    /users/unfollow/:user_id(.:format)                                                       users#unfollow
#                           GET    /users/follow_list/:user_id(.:format)                                                    users#follow_list
#                           GET    /users/follower_list/:user_id(.:format)                                                  users#follower_list
#                refile_app        /attachments                                                                             #<Refile::App app_file="/home/vagrant/.bundle/ruby/2.5.0/refile-46b4178654e6/lib/refile/app.rb">
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users
  resources :contents do                 
    resource :favorites, only: [:create, :destroy]
    resource :comments, only: [:create, :destroy]
    get :timeline, on: :member
    get :search, on: :collection 
    get :confirm, on: :member  
    #  collection = idがつかない
    #  member = idがつく
  end 

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
# bundle exec annotate --routes
