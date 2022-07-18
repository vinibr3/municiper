Rails.application.routes.draw do
  resources :residents, only: %i[index]

  root 'residents#index'
end
