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
  # Handle unmatched routes
  get '*unmatched_route', to: 'homes#server_error'

end
