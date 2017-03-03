Rails.application.routes.draw do
  root to: 'images#index'

  mount ActionCable.server => '/cable'
end
