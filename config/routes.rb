Rails.application.routes.draw do
  devise_for :users,
    defaults: { format: :json },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
  get '/current_user', to: 'current_user#show'
  resources :posts do
    resources :comments
  end
  resources :bookmarks
  resources :tags
end
