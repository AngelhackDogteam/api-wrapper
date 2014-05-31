Rails.application.routes.draw do

  resources :breeds, only: [:index, :show]
end
