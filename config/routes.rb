Rails.application.routes.draw do
  resources :animals
  resources :ongs
  resources :users #, only: [:new, :create, :show, :edit]

  get 'home/index'
  get 'entrar', to:'sessions#new'
  post 'entrar', to:'sessions#create'
  delete 'sair', to:'sessions#destroy'
  #get 'editar', to: 'users#update'

  root to:"home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
