Rails.application.routes.draw do

  resources :posts

  resources :categories do
    resources :sensors do
      resources :values
    end
  end

  resources :payloads

  resources :infos

  root 'public#index'
  get '/update', to: 'infos#update'
  post '/clean', to: 'infos#clean', as: :clean_infos
  get '/about', to: 'public#about'
end
