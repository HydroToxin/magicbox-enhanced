# frozen_string_literal: true

Rails.application.routes.draw do
  # Root Settings for authenticated and unauthenticated users
  devise_scope :user do
    authenticated :user do
      root to: 'dashboard#index', as: :authenticated_root
    end

    unauthenticated do
      root to: 'devise/sessions#new'
    end
  end

  # Devise routes for users
  devise_for :users, skip: [:registrations]

  as :user do
    get 'users/edit/:id' => 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users/:id' => 'devise/registrations#update'
  end

  # Standard routes
  resources :users, only: [:show]
  resources :batches
  resources :observations
  resources :devices, only: [:index]

  # Static page controllers
  get '/dashboard', to: 'dashboard#index'
  get '/journal', to: 'journal#index'
  get '/calendar', to: 'calendar#index'

  # Task-related routes
  resources :todos do
    member do
      post :done
      post :undone
    end
  end

  resources :notifications do
    collection do
      delete :clear_all
    end
  end

  resources :samples, only: [:index] do
    collection do
      get :general
      get :rooms
      get :harvest
    end
  end


  # Nested resources for grows
  resources :grows, except: %i[edit update new create] do
    resources :harvests, only: [:show]
    resources :weeks
    resources :observations
    resources :subjects do
      resources :observations
    end

    member do
      get :print_qr
    end
  end

  # Room-related resources
  resources :rooms, only: [:show] do
    resources :devices, only: [:show] do
      post :query, on: :member
      resources :events # Hinzufügen von Events unter Devices
    end

    resources :events
  end

  # Default events route (falls eigenständige events benötigt werden)
  resources :events
  resources :harvests, only: %i[index new]

  # Admin namespace
  namespace :admin do
    get '/dashboard/gpio', to: 'dashboard#gpio'

    resources :users, except: [:show] do
      member do
        get :update_password
      end
    end

    resources :grows, only: %i[edit update new create destroy] do
      resources :harvests, except: %i[index show] do
        resources :batches, except: %i[index show]
      end
      resources :subjects do
        post :move_to, on: :member
      end
    end

    resources :rooms do
      resources :devices, only: %i[index edit update new create destroy] do
        post :start, on: :member
        post :stop, on: :member
        resources :events # Hinzufügen von Events unter Devices im Admin-Bereich
      end
    end

    resources :strains
    resources :data_types
    resources :batches
    resources :harvests
    resources :weeks
    resources :devices do
      post :start, on: :member
      post :stop, on: :member
    end

    resources :scenarios do
      resources :condition_groups, only: %i[new create destroy] do
        resources :conditions, only: %i[new create destroy]
        resources :operations, only: %i[new create destroy]
      end
      collection do
        get :export
        post :import
      end
    end

    # resources :scenarios do
    #  resources :condition_groups, only: [:new, :create, :destroy] do
    #    resources :conditions, only: [:new, :create, :destroy]
    #    resources :operations, only: [:new, :create, :destroy]
    #  end
    #  member do
    #    post 'run'
    #  end
    #  collection do
    #    get :export
    #    post :import
    #  end
    # end

    resources :scenarios do
      resources :condition_groups, only: %i[new create destroy] do
        resources :conditions, only: %i[new create destroy]
        resources :operations, only: %i[new create destroy]
      end
    end

    resources :condition_groups
    resources :conditions
    resources :operations
    resources :alerts do
      member do
        post :test
        post :trigger
      end
    end
    resources :categories
    resources :resources
    resources :observation_resources
    resources :issues, only: [:new, :destroy]

    resource :settings

    get '/', to: 'users#index'
  end

  # API namespace
  namespace :api do
    namespace :v1 do
      get '/context', to: 'context#index'

      resources :users, only: [:show] do
        resources :push_devices, only: [:create]
      end

      resources :devices, only: %i[index show update] do
        post :start, on: :member
        post :stop, on: :member
        resources :events # API-Unterstützung für verschachtelte Events unter Devices
      end

      resources :rooms
      resources :grows do
        resources :subjects
      end
      resources :subjects do
        resources :observations
      end
      resources :scenarios
      resources :conditions
      resources :operations
      resources :observations
      resources :events

      resources :data_types, only: %i[index show] do
        resources :samples, defaults: { format: :json }, only: %i[index show]
      end

      resources :samples, defaults: { format: :json }, only: %i[index show create]
    end
  end

  # API documentation
  apipie

  # Test route
  get 'test/index'
end
