Rails.application.routes.draw do
  
  namespace :admin do
    root to: 'admin#home'
    resources :users, only: [:index,:edit,:show,:update,:destroy]
    resources :tags, only: [:index,:edit,:update,:destroy]
    resources :posts, only: [:index,:show,:edit,:update,:destroy] 
    resources :playgrounds, only: [:index,:new,:create,:show,:edit,:update,:destroy]
  end


  namespace :admin do
    root to: "homes#top"
    get "about", to:"homes#about"
    resources :posts, only: [:index,:new,:show,:create,:destroy]
    resources :playgrounds, only: [:new,:index,:show,:create,:edit,:update,:destroy]
    get 'users/my_page' => 'users#show'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/unsubscribe' => 'users#unsubscribe'
    patch 'users/withdraw' => 'userrs#withdraw'
  end


  get '/search' => 'seaches#search'

  end
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

end
