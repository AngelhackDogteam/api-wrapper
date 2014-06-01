Rails.application.routes.draw do

  resources :breeds, only: [:index]
  resources :dogs, only: [:index]
  resources :shelters, only: [:index] 
  resources :recommendations, only: [:index]

  get '/recommendations/filter', to: 'recommendations#filter', as: :filter_recommendations
  get '/breeds/random', to: 'breeds#random_pet', as: :random_pet
  get '/breeds/load', to: 'breeds#on_load', as: :load_breeds
end
