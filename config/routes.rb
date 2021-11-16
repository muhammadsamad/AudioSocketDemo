Rails.application.routes.draw do
  devise_for :users
  resources :auditions
  get '/assigned_to_update', to: "auditions#assigned_to_update"
  get '/myresults.csv', to: 'auditions#my_results', :as => :myresults
  get '/status_update', to: 'auditions#status_update'
  mount Ckeditor::Engine => '/ckeditor'
  root to: "auditions#new"
end
