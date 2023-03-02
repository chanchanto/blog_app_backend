Rails.application.routes.draw do
  # current_api_routes = lambda do
  #   devise_for :users,
  #     defaults: { format: :json },
  #     controllers: {
  #       sessions: 'api/v1/users/sessions',
  #       registrations: 'api/v1/users/registrations'
  #     }
  #   get '/current_user', to: 'current_user#show'
  #   resources :posts do
  #     resources :comments
  #   end
  #   resources :bookmarks, only: [ :index, :create, :destroy ]
  #   resources :tags
  # end

  namespace :api do
    # namespace :v1, &current_api_routes
    namespace :v1 do
      devise_for :users,
        defaults: { format: :json },
        controllers: {
          sessions: 'api/v1/users/sessions',
          registrations: 'api/v1/users/registrations'
        }
      get '/current_user', to: 'current_user#show'
      resources :posts do
        resources :comments
      end
      resources :bookmarks, only: [ :index, :create, :destroy ]
      resources :tags
    end
  end
end
