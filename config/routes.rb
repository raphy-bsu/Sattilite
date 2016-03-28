Rails.application.routes.draw do


  resources :payloads

  resources :infos

  root 'infos#index'
  post '/update', to: 'infos#update'
  post '/clean', to: 'infos#clean', as: :clean_infos
  get '/about', to: 'public#about'
end
