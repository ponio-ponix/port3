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
    
  resources :memos, :only => [:index, :show, :edit, :update, :new, :create, :destroy] do
    member do
      get :following
    end
  end

end
