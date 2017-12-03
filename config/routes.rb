Blogplace::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, :only => [:show, :create, :update, :destroy, :index] do
        resources :posts, :only => [:create]
      end

      resources :posts, :only => [:show, :index]
    end
  end

  root to: 'users#index'
end
