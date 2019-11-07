Rails.application.routes.draw do
  get 'events/index'
  root 'events#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :events
  resources :events do
    resources :attendances, only: [:create, :destroy]
  end
end
