Rails.application.routes.draw do
  #Topページ
  root 'static_pages#top'
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'
  get 'recommend_genre', to: 'static_pages#recommend_genre'

  #ユーザー登録、ログイン、ログアウト
  resources :users, only: %i[show new create destroy]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  #書籍検索、詳細、ブックマーク、おすすめ
  resources :books, param: :isbn , only: %i[index show create] do
    collection do
      get :search
      get :genres_search
      get :bookmarks
      get :recommends
    end
    resource :bookmark, only: %i[create destroy]
  end

  #管理者
  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'

    resources :books, param: :isbn, only: %i[index edit update destroy]
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
  end
  get '*path', to: 'application#render_404'
end
