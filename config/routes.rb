Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # ルートページ
  root to: "variouses#top"

  # アバウトページ
  get "variouses/about"       => "variouses#about"

  # ユーザーアクション
  get "users/:id/videos"      => "users#videos", as: "users_videos"
  get "users/withdraw"        => "users#withdraw"
  get "users/:id/favorites" => "users#favorites", as: "users_favorites"

  # 検索機能
  get "search" => "videos#search"

  # 新規会員登録の時のルーティングエラーを修正
  get '/users', to: redirect("/users/sign_up")

  resources :users,           only: [:show, :edit, :update, :destroy] do
    resource :relationships,  only: [:create, :destroy]
    get :follows,   on: :member
    get :followers, on: :member
    # memberはidを取得できるようにする
  end

  # 動画アクション
  resources :videos do
    resource  :likes,      only: [:create, :destroy]
    resource  :favorites,  only: [:create, :destroy]
    resources :comments,   only: [:create, :destroy]
  end

  # ルーム機能
  resources :rooms do
    resources   :room_messages, only: [:create, :destroy]
    resources   :room_videos,   only: [:create, :destroy]
    resource    :room_user,     only: [:create, :destroy]
  end

  resources :notifications, only: :index
end
