Rails.application.routes.draw do
  root to: 'inicio#index'

  devise_for :users
end
