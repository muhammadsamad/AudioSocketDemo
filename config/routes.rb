Rails.application.routes.draw do
  devise_for :users
  resources :auditions
  patch '/update', to: "auditions#update"
  get '/format_csv.csv', to: 'auditions#format_csv', as: :format_csv, defaults: { format: 'csv' }
end
