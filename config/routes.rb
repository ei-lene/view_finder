require 'sidekiq/web'

ViewFinder::Application.routes.draw do

  mount Sidekiq::Web, at: '/sidekiq'

  match 'auth/instagram/callback/' => 'authentications#create'

  root :to => 'site#home'
  
  PhotosController::LOCATION_GAMES.each do |key, value|
    get "photos/#{key.to_s}" => "photos##{key.to_s}"
    post "photos/#{key.to_s}" => 'photos#play'
    get "users/:id/#{key.to_s}" => "photos#saved_#{key.to_s}_game"
    post "users/:id/#{key.to_s}" => "photos#play"
  end

  get "photos/friend_1" => "photos#friends_feed_1"
  get "photos/friend_2" => "photos#friends_feed_2"

  post "photos/friend_1" => "photos#play"
  post "photos/friend_2" => "photos#play"

  get "photos/user_media_feed" => "photos#user_media_feed"

  post "photos/user_media_feed" => "photos#play"


  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  get 'photos/search' => 'photos#search'
  get 'photos/index' => 'photos#index'

  get 'photos/popular' => 'photos#index_popular'
  get 'photos/vfyw' => 'photos#photo_tag'

  get 'photos/:id' => 'photos#show', :as => 'photo'

  get 'users/:id/feed' => "photos#user_media_feed"

  resources :users, :sessions, :authentications, :guesses

end
