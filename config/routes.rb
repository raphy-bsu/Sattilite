Rails.application.routes.draw do

  get 'public/about'

  resources :infos

  root 'infos#index'
  get '/update', to: 'infos#update'
  post '/clean', to: 'infos#clean', as: :clean_infos
end
