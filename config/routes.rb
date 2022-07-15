Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  namespace :accounting do
    resources :transactions
    resources :inventories
    resources :items
    resources :summaries
  end

  get 'dashboard', to: 'dashboard#index'
  get 'histories', to: 'dashboard#index'
  get 'inventories', to: 'dashboard#index'
  get 'summaries', to: 'dashboard#index'

  get "configs", to: 'configs#index'

  get "sessions/destroy"

  get '/auth/:provider/callback', to: 'sessions#create'
  post '/auth/:provider/callback', to: 'sessions#create'

  get 'inventory_settings', to: 'inventory_settings#index'
  put 'inventory_settings', to: 'inventory_settings#update'
end
