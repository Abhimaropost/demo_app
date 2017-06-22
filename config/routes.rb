require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'homes#dashboard'
   resources :homes, only: [] do
    collection do
      get 'about_us'
      get 'contact_us'
      get 'dashboard'
      get 'guest_user'
      get 'app_user'
      get 'server_error'
      post 'contact_mail'
    end
  end

  resources :images do
    collection do
      get 'validate_uniqueness'
      post 'update_title'
    end
  end

 namespace :api do
  namespace :v1 do
    resources :users, only: [:create]
    resources :images, only: [:create,:show]
    resources :homes, except: [:index, :new, :edit, :update,:show,:destroy] do
       collection do
          post 'contact_mail'
       end
    end

  end
end

  mount Sidekiq::Web => '/sidekiq'
  # Handle unmatched routes
  get '*unmatched_route', to: 'homes#server_error'
  post '*unmatched_route', to: 'api/v1/homes#server_error'

end


