Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
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
