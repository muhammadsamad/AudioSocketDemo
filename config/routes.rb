Rails.application.routes.draw do
  devise_for :users
  resources :auditions
  patch '/update', to: "auditions#update"
  get '/csvresult.csv', to: 'auditions#csv_result', as: :csv_result
end
