Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  # You can have the root of your site routed with "root"
  # root 'welcome#index'

end
