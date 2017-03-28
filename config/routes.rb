Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :talks do
        member do
          get 'messages', to: 'talks#messages'
          post 'talks/(:id)/messages', to: 'talks#create_message'
        end
      end

      mount_devise_token_auth_for 'User', at: 'auth'
      get 'users/wishlist', to: 'users#wishlist'
      put 'users', to: 'users#update'
      get 'current_user', to: 'users#current_user'

      get 'featured', to: 'properties#featured'
      get 'search', to: 'properties#search'
      get 'autocomplete', to: 'properties#autocomplete'
      get 'trips', to: 'properties#trips'
      get 'my_properties', to: 'properties#my_properties'
      get 'get_by_property', to: 'reservations#get_by_property'
      resources :properties do
        member do
          post 'wishlist', to: 'properties#add_to_wishlist'
          delete 'wishlist', to: 'properties#remove_from_wishlist'
        end
      end

      resources :reservations do
        member do
          post 'evaluation', to: 'reservations#evaluation'
        end
      end
    end
  end
end
