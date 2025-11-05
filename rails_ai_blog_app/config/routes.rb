# config/routes.rb
Rails.application.routes.draw do
  resources :blogs, only: [:index, :new, :create, :show]
  root to: 'blogs#index'
end
