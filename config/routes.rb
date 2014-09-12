Rails.application.routes.draw do

  resources :infos

  root 'infos#index'
  get '/update', to: 'infos#update'
end
