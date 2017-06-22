Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}

  resources :users do
  	resources :groups, only: [:new, :create, :show, :index] 	
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :channels, only: [:new, :create, :show, :index]

  resources :conversations, only: [:create] do
    member do
      post :close
    end

    resources :direct_messages, only: [:create]
  end  


  mount ActionCable.server => '/cable'

  root to: 'view#home'

  get '/join', to: 'groups#join'

  get 'direct_messages', to: 'conversations#index'
  
end
