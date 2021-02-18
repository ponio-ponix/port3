Rails.application.routes.draw do
  
  root 'tops#top'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, :only => [:show, :index, :edit, :update] do
    collection do
      patch :out
    end
    member do
      get :following, :followers
      get :quit
    end
  end
    
    #followingはログインユーザーのフォローしている人のメモを新着順、mypageはログインユーザーのメモ新着順
    #indexは1つのリレーションメモ
  resources :memos, :only => [:edit, :show, :update, :new, :create, :destroy] do
    collection do
      get :favorite
    end
    member do
      get :following
      get :mypage
      get :memo_relation
    end
    
    resource :favorites, :only => [:create, :destroy]
    resources :comments, :only => [:create, :destroy]

  end
    resources :relationships, :only => [:create, :destroy]
end
