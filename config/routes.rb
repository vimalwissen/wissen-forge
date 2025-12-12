Rails.application.routes.draw do
  root "dashboard#index"
  devise_for :users
  
  get "dashboard", to: "dashboard#index"
  resource :profile, only: [:show]
  resources :users, only: [:show], controller: 'profiles'
  resources :certificates, only: [:show], param: :badge_id
  resources :reports, only: [:index]
  
  resources :trainings do
    member do
      patch :publish
      get :assign
      post :assign_users
    end
    resources :enrollments, only: [:create, :update]
    resources :assignments, only: [:index, :show] do
      resources :submissions, only: [:create]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
