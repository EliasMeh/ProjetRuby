
Rails.application.routes.draw do
  root "home#index"
  resources :authors
  resources :books
end
