Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find_all', to: 'merchants#index'
      get '/merchants/find', to: 'merchants#show'
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end
      get '/items/find', to: 'items#show'
      resources :items, only: [:index, :show]
    end
  end
end
