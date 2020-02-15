Rails.application.routes.draw do
  get 'login' => 'logins#index'

  get 'login/new' => 'logins#new'
  post 'login/new' => 'logins#create'

  get 'board/index' => 'boards#index'
  root 'logins#index'
  post 'board/index' => 'boards#create'
  delete 'board/:id' => 'boards#destroy'
  get 'board/:id/show' => 'boards#show'

  get 'board/:id/comment' => 'board_comments#index', as: 'board_comment' 
  post 'board/:id/comment' => 'board_comments#create'

  resources :members do
    get "search", on: :collection
  end

  resource :session, only: [:create, :destroy]
   
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
