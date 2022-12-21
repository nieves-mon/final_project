Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  root 'static_pages#index'
  get 'index', to: 'static_pages#index'

  get 'dashboard', to: 'home#dashboard'

  resources :users, only: [ :index, :show ] do
    member do
      patch :resend_invitation
    end
  end

  resources :organizations, except: [ :new, :create ] do
    get :invite_a_member_of, on: :collection
  end

  scope "organizations/:id" do
    get "members" => "organizations#members", as: :members
    resources :meetings
  end

end
