Rails.application.routes.draw do
  
  root 'tops#top'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tops, :only => [] do
    collection do
      get :search
    end
  end
  
  resources :users, :only => [:show, :index, :edit, :update] do
    collection do
      patch :out
    end
    member do
      get :following, :followers
      get :quit
      get :favorite
    end
    resources :categories, :only => [:create, :destroy, :update, :edit]
  end
    
    #followingはログインユーザーのフォローしている人のメモを新着順、mypageはログインユーザーのメモ新着順
    #indexは1つのリレーションメモ
  resources :memos, :only => [:index, :edit, :show, :update, :new, :create, :destroy] do
    collection do
      # get :favorite
    end
    member do
      get :following
      get :mypage
    end
    
    resource :favorites, :only => [:create, :destroy]
    resources :comments, :only => [:create, :destroy]

  end
  
  resources :relationships, :only => [:create, :destroy]
    
  

end
