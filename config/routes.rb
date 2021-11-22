Rails.application.routes.draw do
  devise_for :users
  resources :auditions
  patch '/update', to: "auditions#update"
  get '/auditions_csv', to: 'auditions#auditions_csv', as: :auditions_csv
  patch '/update_status_email', to: 'auditions#update_status_email'
  mount Ckeditor::Engine => '/ckeditor'
end
