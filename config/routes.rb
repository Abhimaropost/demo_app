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
    end


  end

  get '*unmatched_route', to: 'homes#server_error'

   # namespace :users do
   #    resources :authentications do
   #      collection do
   #        get 'auth_email'
   #        get 'auth_login'
   #      end

   #    end
   #  end

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

end
