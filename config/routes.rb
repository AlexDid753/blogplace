Blogplace::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, :only => [:show, :create, :update, :destroy, :index]
      resources :posts, :only => [:show, :index, :create]
    end
  end

  root to: 'users#index'
end
