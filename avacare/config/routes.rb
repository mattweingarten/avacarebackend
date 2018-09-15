Rails.application.routes.draw do

  post 'users/:id/conditions', to: 'conditions#create'
  post 'users/:id/symptoms', to: 'symptoms#create'

  post 'users', to: 'users#create'
  get 'users/:id', to: 'users#show'
  post 'login', to: 'users#login'
end
