Rails.application.routes.draw do
  resources :assessments
  resources :courses

  devise_for :users, controllers: { registrations: "registrations"}

  resources :users do
  	resources :groups, only: [:new, :create, :show, :index] 	
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :channels, only: [:new, :create, :show, :index]

  mount ActionCable.server => '/cable'

  root to: 'view#home'

  get '/join', to: 'groups#join'
end
