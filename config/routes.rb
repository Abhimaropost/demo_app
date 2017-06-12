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
      post 'contact_mail'
    end
  end

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

end
