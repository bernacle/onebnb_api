Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      mount_devise_token_auth_for 'User', at: 'auth'
      get 'users/wishlist', to: 'users#wishlist'
      resources :users, only: [:update]

      get 'autocomplete', to: 'properties#autocomplete'
      get 'search', to: 'properties#search'
      resources :properties do
        member do
          post 'wishlist',    to: 'properties#add_to_wishlist'
          delete 'wishlist',  to: 'properties#remove_from_wishlist'
        end
      end

      resources :reservations do
        member do
          post 'evaluation', to: 'reservation#evaluation'
        end
      end
    end
  end
end
