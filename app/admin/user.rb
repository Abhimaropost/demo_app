ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation
  menu priority: 2
  config.batch_actions = false
  config.filters = false


  # index do
  #   selectable_column
  #   id_column
  #   column :email
  #   column :current_sign_in_at
  #   column :sign_in_count
  #   column :created_at
  #   actions
  # end



  index do
    column "Email",:email do |f|
      f.email
    end
    column "Current SignIn at",:current_sign_in_at do |f|
      f.current_sign_in_at
    end
    column "SignIn count",:sign_in_count do |f|
      f.sign_in_count
    end
    column "Created at",:created_at do |f|
      f.created_at
    end

    column "Action" do |user|
      a do
        link_to 'View', admin_user_path(user)
      end
      a do
        link_to 'Edit', edit_admin_user_path(user)
      end

     # a do
     #    link_to 'Delete' , admin_users_path(user), method: :delete, :data => {:confirm => "Are you sure you want to delete this user?"}
     #  end



    end
  end




  show :title => :email do
    attributes_table do
      row :email
      row :current_sign_in_at
      row :sign_in_count
      row :created_at
    end
  end



  # filter :email
  # filter :current_sign_in_at
  # filter :sign_in_count
  # filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end



end
