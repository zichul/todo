Rails.application.routes.draw do


  resources :lists
  resources :todos, only: [:create, :update, :destroy]
  post 'toggle/:id' => 'todos#toggle', as: 'toggle_todo'

  get 'reset_token/:id' => 'lists#reset_token', as: 'reset_token'
  get 'shared/:token' => 'lists#shared', as: 'shared'

  get 'account' => 'users#show'
  post 'account' => 'users#create', as: 'users'
  get 'account/edit' => 'users#edit'
  post 'account/edit' => 'users#update'
  delete 'account/delete' => 'users#destroy'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get 'register' => 'users#new', as: 'registration'

  root to: 'lists#index'

end
