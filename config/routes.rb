Rails.application.routes.draw do
  get 'deliveries/index'
  devise_for :users
  root to: "items#index"
  resources :items
end
