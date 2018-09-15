Rails.application.routes.draw do
  get 'users/:id/createCondition', to: 'conditions#new'
  get 'createUser', to: 'users#new'
  get 'users/:id', to: 'users#show'
  get 'users/:id/conditions', to: 'conditions#show'
end
