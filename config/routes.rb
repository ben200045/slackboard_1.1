Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  resources :users do
  	resources :groups, only: [:new, :create, :show, :index]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :channels, only: [:new, :create, :show, :index]

  mount ActionCable.server => '/cable'

  root to: 'view#landing'

  scope '/api' do
      scope '/groups' do
        get '/', to: 'groups_api#index', as: 'groups_index_api'
        get '/:id', to: 'groups_api#show', as: 'groups_show_api'
      end
      scope '/channels' do
        get '/',  to: 'channels_api#index', as: 'channels_index_api'
        get '/:id', to: 'channels_api#show', as: 'channels_show_api'

    end
  end
end
