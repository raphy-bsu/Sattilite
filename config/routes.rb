Rails.application.routes.draw do
  mount Sputnik::API, at: '/'
  mount GrapeSwaggerRails::Engine => '/docs'

  devise_for :users

  scope module: 'public' do
    resources :posts, only: [:index, :show]
    resources :messages, only: [:create]
  end

  authenticate do
    namespace :developer do
      root to: 'dashboard#index'
    end

    namespace :admin do
      root to: 'posts#index'

      resources :messages, except: [:edit, :create, :update]
      resources :posts
      resources :users

      resources :categories, except: [:show] do
        resources :sensors, except: [:show] do
          resources :values, only: [:index, :destroy] do
            delete :destroy_all, on: :collection
          end
        end
      end

    end
  end

  root 'public#index'
  get '/about', to: 'public#about'
  get '/contact_us', to: 'public#contact_us'
end
