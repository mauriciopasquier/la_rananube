Rails.application.routes.draw do
  root to: 'inicio#index'

  devise_for :users

  # Gestión de usuarixs.
  resources :users do
    patch :roles, on: :member
  end
end
