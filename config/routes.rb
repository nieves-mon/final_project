Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  get 'home/index'
  root 'home#index'

  resources :users, only: [ :index, :show ] do
    member do
      patch :resend_invitation
    end
  end

  resources :tenants do
    get :invite_a_member_of, on: :collection
  end

end
