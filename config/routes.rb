Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  root 'static_pages#index'
  get 'index', to: 'static_pages#index'
  get 'dashboard', to: 'home#dashboard'
  get 'projectuser', to: 'projects#projectuser'

  resources :users do
    member do
      patch :resend_invitation
    end
  end

  resources :organizations, except: [ :new, :create, :index ] do
    get :invite_a_member_of, on: :collection
  end

  scope "organizations/:organization_id" do
    resources :meetings do
      get "/new_user" => "meetings#new_user", as: :new_user
      post "/new_user" => "meetings#create_user"
    end
    resources :projects do
        resources :tasks, except: [ :index ]
        resources :project_participants
        get "project_participants/delete" => "project_participants#delete", as: :delete
        post "project_participants/delete" => "participants#destroy"
    end
  end

end
