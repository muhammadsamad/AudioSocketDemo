Rails.application.routes.draw do
  devise_for :users
  resources :auditions
  get '/myresults.csv', to: 'auditions#my_results', :as => :myresults
end
