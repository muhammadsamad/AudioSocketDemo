Rails.application.routes.draw do
  devise_for :users
  resources :auditions do
    get '/format_csv.csv', to: 'auditions#format_csv', as: :format_csv, defaults: { format: 'csv' }, on: :collection
  end
end
