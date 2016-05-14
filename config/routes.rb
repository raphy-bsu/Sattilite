Rails.application.routes.draw do


  resources :values

  resources :sensors

  resources :categories

  resources :payloads

  resources :infos

  root 'infos#index'
  get '/update', to: 'infos#update'
  post '/clean', to: 'infos#clean', as: :clean_infos
  get '/about', to: 'public#about'
end
