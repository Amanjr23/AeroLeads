# config/routes.rb
Rails.application.routes.draw do
  root to: 'phone_numbers#new'
  resources :phone_numbers, only: [:new, :create, :index]
end
