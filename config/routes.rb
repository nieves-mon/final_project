Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  root 'home#dashboard'
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
      resources :participants, only: [ :new, :create, :destroy ]
    end

    resources :projects do
        resources :tasks, except: [ :index ]
        resources :project_participants
    end
  end
end
