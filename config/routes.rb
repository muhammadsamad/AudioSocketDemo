Rails.application.routes.draw do
  devise_for :users
  resources :auditions
  patch '/update', to: "auditions#update"
end
