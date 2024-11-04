Rails.application.routes.draw do
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
    root to: 'admin#home'
    resources :users, only: [:index, :edit, :show, :update, :destroy]
    resources :tags, only: [:index, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create,:destroy]
    end
    resources :playgrounds, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end
  

   scope module: :public do
    root to: "homes#top"
    get "about", to: "homes#about"
    resources :posts, only: [:index, :new, :show, :create, :destroy] do
      resources :post_comments, only: [:create,:destroy]
    end
    resources :playgrounds, only: [:new, :index, :show, :create, :edit, :update, :destroy]
    get '/mypage' => 'users#mypage'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/unsubscribe' => 'users#unsubscribe'
    patch 'users/withdraw' => 'users#withdraw'
    resources :users, only: [:show, :edit, :update] 
    post "guest_sign_in", to: "sessions#guest_sign_in"
  end

  get '/search' => 'searches#search'


  

end
