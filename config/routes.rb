Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # ルートページ
  root to: "variouses#top"

  # アバウトページ
  get "variouses/about"       => "variouses#about"

  # ユーザーアクション
  get "users/:id/videos"      => "users#videos" ,     as: "users_videos"
  get "users/withdraw"        => "users#withdraw"
  get "users/favorites"       => "users#favorites"

  resources :users,           only: [:show, :edit, :update] do
    resource :relationships,  only: [:create, :destroy] do
      get :follows,   on: :member
      get :followers, on: :member
      # memberはidを取得できるようにする
    end
  end

  # 動画アクション
  resources :videos do
    resource  :likes,      only: [:create, :destroy]
    resource  :favorites,  only: [:create, :destroy]
    resources :comments,   only: [:create, :destroy]
  end

end
