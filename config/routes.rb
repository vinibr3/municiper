Rails.application.routes.draw do
  resources :residents, only: %i[index create update]

  root 'residents#index'
end
