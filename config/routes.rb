Rails.application.routes.draw do
  devise_for :users
  resources :auditions
  patch '/update', to: "auditions#update"
  get '/auditions_csv', to: 'auditions#auditions_csv', as: :auditions_csv
  patch '/update_status_email', to: 'auditions#update_status_email'
  mount Ckeditor::Engine => '/ckeditor'
  resources :artist_details, shallow: true do
    resources :albums do
      resources :tracks
    end
  end
  post 'transaction', to: "artist_details#transaction", as: "transaction"
  authenticated :user, ->(u) { u.role == "Manager" } do
    root to: "auditions#index"
  end
  root to: "auditions#new"
end
