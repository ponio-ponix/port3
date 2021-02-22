Rails.application.routes.draw do
  
  root 'tops#top'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
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
    
  resources :memos, :only => [:index, :show, :new, :create] do
    member do
      get :following
      get :mypage
    end
    
    resource :favorites, :only => [:create, :destroy]
    resources :comments, :only => [:create, :destroy]
  end
  
  resources :relationships, :only => [:create, :destroy]

end
