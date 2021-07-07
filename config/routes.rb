Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find_all', to: 'merchants#index'
      get '/merchants/find', to: 'merchants#show'

      get '/items/find_all', to: 'items#index'
      get '/items/find', to: 'items#show'

      get '/invoice_items/find_all', to: 'invoice_items#index'
      get '/invoice_items/find', to: 'invoice_items#show'

      get '/invoices/find_all', to: 'invoices#index'
      get '/invoices/find', to: 'invoices#show'

      get '/transactions/find_all', to: 'transactions#index'
      get '/transactions/find', to: 'transactions#show'

      get '/customers/find_all', to: 'customers#index'
      get '/customers/find', to: 'customers#show'

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end
      resources :invoice_items, only: [:index, :show] do
        get '/invoice', to: 'invoices#show'
        get '/item', to: 'items#show'
      end
      resources :items, only: [:index, :show] do
        resources :invoice_items, only: [:index]
        get '/merchant', to: 'merchants#show'
      end
      resources :invoices, only: [:index, :show] do
        get '/transactions', to: 'transactions#index'
        get '/items', to: 'items#index'
        get '/invoice_items', to: 'invoice_items#index'
        get '/customer', to: 'customers#show'
        get '/merchant', to: 'merchants#show'
      end
      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index]
        resources :transactions, only: [:index]
      end
      resources :transactions, only: [:index, :show] do
        get '/invoice', to: 'invoices#show'
      end
    end
  end
end
