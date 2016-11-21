Rails.application.routes.draw do
  resources :microposts
  get 'sessions/new'

  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'calender/weekly' => 'microposts#weekly'
  get 'calender/monthly' => 'microposts#monthly'
  resources :users do
    member do
      get 'history'
    end
  end
  
  resources :microposts do
    collection do
      get 'weekly'
      get 'monthly'
    end
  end
end
