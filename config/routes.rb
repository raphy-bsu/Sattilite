Rails.application.routes.draw do

  resources :data

  root 'public#index'
  get '/update', to: 'public#update'
end
