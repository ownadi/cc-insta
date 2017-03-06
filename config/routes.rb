Rails.application.routes.draw do
  root to: 'images#index'

  resources :images, only: [:show, :destroy]

  mount ActionCable.server => '/cable'
end
