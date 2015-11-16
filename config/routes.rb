Rails.application.routes.draw do


  get 'account' => 'users#show'
  post 'account' => 'users#create', as: 'users'
  get 'account/edit' => 'users#edit'
  post 'account/edit' => 'users#update'
  delete 'account/delete' => 'users#destroy'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get 'register' => 'users#new', as: 'registration'

  root to: 'sessions#new'

end
