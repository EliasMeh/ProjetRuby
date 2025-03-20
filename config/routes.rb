Rails.application.routes.draw do
  root "home#index"

  resources :authors
  resources :books do
    member do
      patch :mark_as_taken
      patch :mark_as_returned
    end
  end
end
