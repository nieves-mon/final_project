Rails.application.routes.draw do
  get 'static_pages/index'
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  get 'home/index'
  root 'home#index'
  get 'home/dashboard'

  resources :users, only: [ :index, :show ] do
    member do
      patch :resend_invitation
    end
  end

  resources :organizations, except: [ :new, :create ] do
    get :invite_a_member_of, on: :collection
  end

end
