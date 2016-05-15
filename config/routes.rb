Rails.application.routes.draw do


  devise_for :users

  resources :posts, only: [:index, :show]
  resources :messages, only: [:new]

  authenticate do
    namespace :admin do
      root to: 'admin#index'

      resources :messages
      resources :posts

      resources :categories do
        resources :sensors do
          resources :values do
            post :clean, on: :collection
          end
        end
      end

    end
  end

  root 'public#index'
  get '/about', to: 'public#about'
  get '/contact_us', to: 'public#contact_us'
end
