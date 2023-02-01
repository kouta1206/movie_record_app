Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # auth_token
      resources :auth_token, only:[:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end
      resources :movies, only:[:index, :show, :create, :new] do
        get :search, on: :collection
      end
      resources :access_tmdb, only:[:index]
    end
  end
end
