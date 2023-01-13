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
      resources :participants, except: [ :edit, :update, :show, :destroy ]
      get "participants/delete" => "participants#delete", as: :delete
      post "participants/delete" => "participants#destroy"
    end
    resources :projects do
        resources :tasks, except: [ :index ]
        resources :project_participants

          #get "delete_people", to: "project_participants#delete_people"
          #delete "delete_people", to: "project_participants#delete_people"

<<<<<<< HEAD
        # get "project_participants" => "project_participants#delete_people", as: :delete_people
=======
        get "project_participants" => "project_participants#delete_people", as: :delete
>>>>>>> 6d9f985d9727aff8873a3d094b025ad867d25e38
        #post "project_participants/delete" => "participants#destroy"
        end
    end
  end

  #get "delete_people", to: "project_participants#delete_people"
<<<<<<< HEAD
  #delete "delete_people", to: "project_participants#delete_people"
end
=======
  #delete "delete_people", to: "project_participants#delete_people"
>>>>>>> 6d9f985d9727aff8873a3d094b025ad867d25e38
