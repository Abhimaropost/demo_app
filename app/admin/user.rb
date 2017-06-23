ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation
  menu priority: 2
  config.batch_actions = false
  config.filters = false

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  show :title => :email do
    attributes_table do
      row :email
      row :current_sign_in_at
      row :sign_in_count
      row :created_at
    end
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end



end
