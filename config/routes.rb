Rails.application.routes.draw do
  mount Sputnik::API, at: '/'
  mount GrapeSwaggerRails::Engine => '/docs'

  devise_for :users

  scope module: 'public' do
    resources :posts, only: [:index, :show]
    resources :messages, only: [:new, :create]
  end

  authenticate do
    namespace :admin do
      root to: 'posts#index'

      resources :messages, except: [:edit]
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
