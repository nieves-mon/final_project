Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  root 'static_pages#index'
  get 'index', to: 'static_pages#index'
  get 'dashboard', to: 'home#dashboard'

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
      get "/delete_user" => "meetings#delete_user"
      post "/delete_user" => "meetings#destroy_user"
    end
    resources :projects
  end

end
