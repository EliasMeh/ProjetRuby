Rails.application.routes.draw do
  root "home#index"   # This sets the home page as the landing page

  # Routes for authors
  resources :authors

  # Routes for books
  resources :books

  # You can add additional routes if needed
end
