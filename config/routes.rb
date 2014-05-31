Rails.application.routes.draw do

  resources :breeds, only: [:index]
  resources :dogs, only: [:index]
  resources :shelters, only: [:index] 
end
