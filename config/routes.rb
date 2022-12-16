Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  devise_for :users, :controllers => { registrations: 'users/registrations' } do
    get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end

  resources :users, only: [ :index, :show ] do
    member do
      patch :resend_invitation
    end
  end

  resources :organizations, except: [ :new, :create ] do
    get :invite_a_member_of, on: :collection
  end

end
