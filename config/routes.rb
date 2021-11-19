Rails.application.routes.draw do
  devise_for :users
  resources :auditions
end
