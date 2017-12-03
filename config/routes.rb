Blogplace::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, :only => [:show, :create, :update, :destroy, :index]
    end
  end

  root to: 'users#index'
end
