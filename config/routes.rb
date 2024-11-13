Rails.application.routes.draw do
  namespace :public do
    get 'tags/index'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end


  namespace :admin do
    root to: 'sessions#new', as: :admin_root
    resources :users, only: [:index, :edit, :show, :update, :destroy]
    resources :tags, only: [:index, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create,:destroy]
      delete 'remove_image', on: :member
    end
    resources :tags, only: [:index]
    resources :playgrounds, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end
  

   scope module: :public do
    root to: "homes#top"
    get "about", to: "homes#about"
    resources :posts, only: [:index, :new, :show, :create, :destroy] do
      resources :post_comments, only: [:create,:destroy]
    end
    resources :playgrounds, only: [:new, :index, :show, :create, :edit, :update]do
      member do
        delete :remove_image
      end
    end
    resources :tags, only: [:index]
    get '/mypage' => 'users#mypage', as: :mypage
    get 'users/unsubscribe' => 'users#unsubscribe'
    patch 'users/withdraw' => 'users#withdraw'
    resources :users, only: [:show, :edit, :update] 
    post "guest_sign_in", to: "sessions#guest_sign_in"
    resources :tags, only: [:show] do
      get 'playgrounds', to: 'playgrounds#tagged', as: :playgrounds
    end
    get 'search', to: 'searches#search', as: 'search'
  end

end
