Rails.application.routes.draw do
  devise_for :users
  resources :auditions do
    get '/format_csv.csv', to: 'auditions#format_csv', as: :format_csv, defaults: { format: 'csv' }, on: :collection
    get '/status_update', to: 'auditions#status_update'
    patch '/change_status_send_email', to: 'auditions#change_status_send_email'
  end
  mount Ckeditor::Engine => '/ckeditor'
end
