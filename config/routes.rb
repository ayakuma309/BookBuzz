Rails.application.routes.draw do
  root 'static_pages#top'
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'
  resources :users, only: %i[show new create destroy]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :books, param: :isbn , only: %i[index show new create] do
    collection do
      get :search
      get :genres_search
      get :bookmarks
    end
    resource :bookmark, only: %i[create destroy]
  end

  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'

    resources :books, param: :isbn, only: %i[index edit update destroy]
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
  end
end
