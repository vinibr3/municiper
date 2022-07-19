Rails.application.routes.draw do
  resources :residents, only: %i[index create]

  root 'residents#index'
end
