Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # auth_token
      resource :auth_token, only:[:create, :update, :destroy]
      # movies
      resources :movies, only:[:index, :show, :create, :destroy, :update]
      # access_tmdb
      resources :access_tmdb, only:[:index]
      # genres
      resources :genres, only:[:index]
      # starrings
      resources :starrings, only:[:index]
    end
  end
end
