Rails.application.routes.draw do
  get 'login' => 'logins#index'

  get 'login/new' => 'logins#new'
  post 'login/new' => 'logins#create'
  get 'login/edit' => 'logins#edit', as: 'login_edit'
  patch 'login/edit' => 'logins#update'
  post 'login/edit' => 'logins#update'

  get 'board/index' => 'boards#index'
  root 'logins#index'
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

  resource :session, only: [:create, :destroy]
   
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
