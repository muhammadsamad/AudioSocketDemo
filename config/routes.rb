Rails.application.routes.draw do
  devise_for :users
  resources :auditions, only: [:new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
