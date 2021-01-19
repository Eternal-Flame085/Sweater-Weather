Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'weather#index'
      get '/backgrounds', to: 'background#index'
      post '/users', to: 'users#create'
      post '/sessions', to: 'sessions#create'
      post '/road_trip', to: 'trips#create'

      get 'munchies', to: 'munchies#index'
    end
  end
end
