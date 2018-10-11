Rails.application.routes.draw do

  if Rails.env.production?
    mount Shrine.presign_endpoint(:cache) => '/presign'
  end
  
  root 'static_pages#home'

  get 'privacy' => 'static_pages#privacy'
  get 'terms' => 'static_pages#terms'
  get 'become-member' => 'static_pages#become_member'
  get 'about' => 'static_pages#about'
  get 'updates' => 'static_pages#updates'
  get 'faq' => 'static_pages#faq'

  get 'search' => 'users/videos#search'

  devise_for :users, controllers: { sessions: "users/sessions", passwords: "users/passwords", registrations: "users/registrations", confirmations: "users/confirmations",  unlocks: "users/unlocks"}

  devise_scope :user do
    get 'sign_out', to: 'users/sessions#destroy', path: 'sign-out'
    get 'sign_in', to: 'users/sessions#new', path: 'sign-in'
    get 'register', to: 'users/registrations#new'
  end

  resources :users, controller: 'users/users', only: :show do
    resource :profile, controller: 'users/profiles', only: [:edit, :update]
    resource :source, controller: 'users/sources', only: [:edit, :update]
    resource :membership, controller: 'users/memberships', except: [:show, :index]
    resource :merchant, controller: 'users/merchants', only: [:new, :create, :edit, :update]
    resource :plan, controller: 'users/plans', except: [:show, :index]
    resources :videos, controller: 'users/videos', except: :index do
      resources :comments, controller: 'users/comments', only: [:create, :update, :destroy]
    end
    get 'about' => 'users/users#about'
    get 'subscriptions' => 'users/users#subscriptions'
  end

  resources :subscriptions, controller: 'users/subscriptions', only: [:create, :destroy]
  resources :categories, controller: 'categories/categories' do
    resources :subcategories, controller: 'categories/subcategories', except: :index
  end

end
