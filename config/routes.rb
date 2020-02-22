Rails.application.routes.draw do

  get 'login/edit' => 'logins#edit', as: 'login_edit'
  patch 'login/edit' => 'logins#update'
  post 'login/edit' => 'logins#update'

  get 'board/index' => 'boards#index'
  post 'board/index' => 'boards#create'
  delete 'board/:id' => 'boards#destroy'
  get 'board/:id/show' => 'boards#show', as: 'board_show'
  get 'board/:id/edit' => 'boards#edit', as: 'board_edit'
  post 'board/:id/edit' => 'boards#update'

  get 'board/:id/comment' => 'board_comments#index', as: 'board_comment' 
  post 'board/:id/comment' => 'board_comments#create'

  resources :members do
    get "search", on: :collection
  end

  get '/login' => 'sessions#index', as: 'login_index'
  post '/login' => 'sessions#login' 
  delete '/login' => 'sessions#destroy'
  get 'login/new' => 'sessions#new', as: 'login_new'
  post 'login/new' => 'sessions#create'

  root "sessions#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
