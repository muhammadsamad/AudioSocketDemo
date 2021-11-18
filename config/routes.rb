Rails.application.routes.draw do
  devise_for :users
  resources :auditions
  patch '/update', to: "auditions#update"
  get '/myresults.csv', to: 'auditions#my_results', as: :myresults
end
